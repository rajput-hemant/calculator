import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Fetches exchange rates from two keyless providers and merges them:
///
/// - Frankfurter v2 (`/v2/rates`) covers ~160 currencies in one request and is
///   the primary source whenever it publishes a code.
/// - The fawazahmed0 currency-api covers 300+ codes but has weaker provenance,
///   so it only fills in the codes Frankfurter omits (BGN, HRK, VED, and every
///   other currency outside the v2 set).
///
/// Both providers quote "units per 1 USD", so a cross rate is still
/// `rate[to] / rate[from]`.
class MoneyConverter {
  static const String _frankfurterEndPoint =
      "https://api.frankfurter.dev/v2/rates?base=USD";

  static const String _fallbackEndPoint =
      "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json";

  /// Documented mirror of the fallback, byte-identical, tried when the CDN
  /// host fails.
  static const String _fallbackMirrorEndPoint =
      "https://latest.currency-api.pages.dev/v1/currencies/usd.json";

  /// Both providers republish at most once per day, so polling more often only
  /// re-downloads identical data. 6h keeps the network cost to a few calls a
  /// day and still picks up each new publication the same day.
  static const Duration _ttl = Duration(hours: 6);

  static const String _ratesKey = "rates";
  static const String _lastUpdatedKey = "lastUpdated";

  /// Returns the canonical cache payload:
  /// `{"date", "frankfurterDate", "fallbackDate", "fetchedAt", "data"}`.
  ///
  /// [date] is the older of the two provider dates (see [mergeRates]); [data]
  /// maps `CODE` to units per USD. The cache path and the network path return
  /// the same shape. [refreshing] forces a refetch, and a failed fetch falls
  /// back to the cache when one exists.
  static Future<Map<String, dynamic>> fetchRates({
    bool refreshing = false,
    http.Client? client,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = _decodeCache(prefs.getString(_ratesKey));
    final lastUpdated = prefs.getInt(_lastUpdatedKey);

    if (!refreshing &&
        cached != null &&
        lastUpdated != null &&
        DateTime.now().millisecondsSinceEpoch - lastUpdated <
            _ttl.inMilliseconds) {
      return cached;
    }

    try {
      final primaryBody = await _get(client, _frankfurterEndPoint);
      final fallbackBody = await _get(client, _fallbackEndPoint) ??
          await _get(client, _fallbackMirrorEndPoint);

      final primary = primaryBody == null ? null : parseFrankfurter(primaryBody);
      final fallback = fallbackBody == null ? null : parseFallback(fallbackBody);

      // A strict superset fallback means one working provider is enough; only
      // when both fail is there nothing to serve.
      if (primary == null && fallback == null) {
        throw Exception("Failed to load rates");
      }

      final merged = mergeRates(
        primary: primary,
        fallback: fallback,
        fetchedAt: DateTime.now().millisecondsSinceEpoch,
      );
      await prefs.setString(_ratesKey, jsonEncode(merged));
      await prefs.setInt(_lastUpdatedKey, merged["fetchedAt"] as int);
      return merged;
    } catch (_) {
      // Serve the stale cache instead of a broken screen; rethrow only when
      // there is nothing cached to fall back to.
      if (cached != null) return cached;
      rethrow;
    }
  }

  /// Reshapes a Frankfurter `/v2/rates?base=USD` body into the same map the
  /// old `/v1/latest` parser produced: `{"date", "rates": {CODE: units per
  /// USD}}`. Unlike v1's object form, v2 returns a flat array of pairs that can
  /// carry several dates in one payload, so the record date is the OLDEST date
  /// present: never claim fresher data than we actually have.
  static Map<String, dynamic>? parseFrankfurter(String body) {
    final records = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
    final dates = records.map((r) => r["date"] as String).toList()..sort();
    return {
      "date": dates.first,
      "rates": <String, double>{
        for (final r in records) r["quote"] as String: (r["rate"] as num).toDouble(),
        "USD": 1.0, // Injected for safety; v2 already includes the base.
      },
    };
  }

  /// Reshapes a fawazahmed0 `/v1/currencies/usd.json` body. Keys are lowercase
  /// and the base is already present, so only the case needs normalising.
  static Map<String, dynamic>? parseFallback(String body) {
    final decoded = jsonDecode(body) as Map<String, dynamic>;
    final raw = decoded["usd"] as Map<String, dynamic>;
    return {
      "date": decoded["date"],
      "rates": <String, double>{
        for (final entry in raw.entries)
          entry.key.toUpperCase(): (entry.value as num).toDouble(),
      },
    };
  }

  /// Merges both provider payloads into one map, primary winning per code.
  static Map<String, dynamic> mergeRates({
    Map<String, dynamic>? primary,
    Map<String, dynamic>? fallback,
    int? fetchedAt,
  }) {
    final data = <String, double>{};
    final fallbackRates = fallback?["rates"] as Map<String, double>?;
    if (fallbackRates != null) data.addAll(fallbackRates);
    final primaryRates = primary?["rates"] as Map<String, double>?;
    if (primaryRates != null) data.addAll(primaryRates);

    // The two sources can legitimately land a day apart, so show the older of
    // the two: never claim fresher data than we actually have. ISO dates sort
    // chronologically as plain strings.
    final dates = [primary?["date"], fallback?["date"]]
        .whereType<String>()
        .toList()
      ..sort();

    return {
      "date": dates.isEmpty ? null : dates.first,
      "frankfurterDate": primary?["date"],
      "fallbackDate": fallback?["date"],
      "fetchedAt": fetchedAt,
      "data": data,
    };
  }

  /// Returns the body on HTTP 200, or null on any failure so the caller can
  /// degrade to the other provider instead of throwing.
  static Future<String?> _get(http.Client? client, String url) async {
    try {
      final uri = Uri.parse(url);
      final response =
          client == null ? await http.get(uri) : await client.get(uri);
      return response.statusCode == 200 ? response.body : null;
    } catch (_) {
      return null;
    }
  }

  /// Decodes the cache, ignoring a missing or legacy-shaped entry so an old
  /// Frankfurter body from a previous version is refetched instead of crashing.
  static Map<String, dynamic>? _decodeCache(String? body) {
    if (body == null) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic> && decoded["data"] is Map) {
        return decoded;
      }
    } catch (_) {
      // fall through to null
    }
    return null;
  }
}
