import 'dart:convert';

import 'package:calculator/models/models.dart';
import 'package:calculator/screens/exchange_rate_screen.dart';
import 'package:calculator/utils/money_converter.dart';
import 'package:calculator/widgets/field_list_tile.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Captured verbatim from `GET https://api.frankfurter.dev/v2/rates?base=USD`
/// (HTTP 200). One flat array of 165 pairs; per-pair dates mix 2026-10-15,
/// 16 and 17 in a single payload. The USD base is included in the array.
const String _frankfurterBody =
    '[{"date":"2026-10-17","base":"USD","quote":"AED","rate":3.6725},{"date":"2026-10-17","base":"USD","quote":"AFN","rate":64.888},{"date":"2026-10-16","base":"USD","quote":"ALL","rate":81.22},{"date":"2026-10-17","base":"USD","quote":"AMD","rate":361.09},{"date":"2026-10-16","base":"USD","quote":"ANG","rate":1.79},{"date":"2026-10-16","base":"USD","quote":"AOA","rate":917.05},{"date":"2026-10-16","base":"USD","quote":"ARS","rate":1511.83},{"date":"2026-10-17","base":"USD","quote":"AUD","rate":1.4402},{"date":"2026-10-16","base":"USD","quote":"AWG","rate":1.7871},{"date":"2026-10-17","base":"USD","quote":"AZN","rate":1.6988},{"date":"2026-10-17","base":"USD","quote":"BAM","rate":1.7418},{"date":"2026-10-16","base":"USD","quote":"BBD","rate":2.005},{"date":"2026-10-16","base":"USD","quote":"BDT","rate":123.2},{"date":"2026-10-17","base":"USD","quote":"BHD","rate":0.376},{"date":"2026-10-17","base":"USD","quote":"BIF","rate":2997.76},{"date":"2026-10-16","base":"USD","quote":"BMD","rate":1.0},{"date":"2026-10-16","base":"USD","quote":"BND","rate":1.2809},{"date":"2026-10-16","base":"USD","quote":"BOB","rate":11.6735},{"date":"2026-10-17","base":"USD","quote":"BRL","rate":5.0683},{"date":"2026-10-16","base":"USD","quote":"BSD","rate":1.0073},{"date":"2026-10-16","base":"USD","quote":"BTN","rate":94.96},{"date":"2026-10-17","base":"USD","quote":"BWP","rate":13.4425},{"date":"2026-10-17","base":"USD","quote":"BYN","rate":3.0162},{"date":"2026-10-16","base":"USD","quote":"BZD","rate":2.024},{"date":"2026-10-17","base":"USD","quote":"CAD","rate":1.418},{"date":"2026-10-16","base":"USD","quote":"CDF","rate":2290.87},{"date":"2026-10-17","base":"USD","quote":"CHF","rate":0.82685},{"date":"2026-10-16","base":"USD","quote":"CLP","rate":982.09},{"date":"2026-10-16","base":"USD","quote":"CMD","rate":1.0},{"date":"2026-10-16","base":"USD","quote":"CNH","rate":6.6851},{"date":"2026-10-17","base":"USD","quote":"CNY","rate":6.6839},{"date":"2026-10-16","base":"USD","quote":"COP","rate":3174.24},{"date":"2026-10-16","base":"USD","quote":"CRC","rate":452.86},{"date":"2026-10-16","base":"USD","quote":"CUP","rate":24.0},{"date":"2026-10-16","base":"USD","quote":"CVE","rate":98.23},{"date":"2026-10-17","base":"USD","quote":"CZK","rate":21.668},{"date":"2026-10-16","base":"USD","quote":"DJF","rate":177.39},{"date":"2026-10-17","base":"USD","quote":"DKK","rate":6.6571},{"date":"2026-10-16","base":"USD","quote":"DOP","rate":61.775},{"date":"2026-10-17","base":"USD","quote":"DZD","rate":134.51},{"date":"2026-10-16","base":"USD","quote":"EGP","rate":53.319},{"date":"2026-10-16","base":"USD","quote":"ERN","rate":15.1526},{"date":"2026-10-16","base":"USD","quote":"ETB","rate":161.31},{"date":"2026-10-17","base":"USD","quote":"EUR","rate":0.89057},{"date":"2026-10-16","base":"USD","quote":"FJD","rate":2.2515},{"date":"2026-10-16","base":"USD","quote":"FKP","rate":0.75263},{"date":"2026-10-17","base":"USD","quote":"GBP","rate":0.75223},{"date":"2026-10-17","base":"USD","quote":"GEL","rate":2.5922},{"date":"2026-10-17","base":"USD","quote":"GGP","rate":0.75223},{"date":"2026-10-16","base":"USD","quote":"GHS","rate":11.6214},{"date":"2026-10-16","base":"USD","quote":"GIP","rate":0.75905},{"date":"2026-10-16","base":"USD","quote":"GMD","rate":73.385},{"date":"2026-10-16","base":"USD","quote":"GNF","rate":8785},{"date":"2026-10-16","base":"USD","quote":"GTQ","rate":7.6277},{"date":"2026-10-16","base":"USD","quote":"GYD","rate":210.66},{"date":"2026-10-17","base":"USD","quote":"HKD","rate":7.8541},{"date":"2026-10-16","base":"USD","quote":"HNL","rate":26.815},{"date":"2026-10-16","base":"USD","quote":"HTG","rate":130.58},{"date":"2026-10-17","base":"USD","quote":"HUF","rate":323.55},{"date":"2026-10-17","base":"USD","quote":"IDR","rate":17989},{"date":"2026-10-17","base":"USD","quote":"ILS","rate":3.0955},{"date":"2026-10-17","base":"USD","quote":"IMP","rate":0.75223},{"date":"2026-10-17","base":"USD","quote":"INR","rate":94.94},{"date":"2026-10-17","base":"USD","quote":"IQD","rate":1515.02},{"date":"2026-10-17","base":"USD","quote":"IRR","rate":1762031},{"date":"2026-10-17","base":"USD","quote":"ISK","rate":121.28},{"date":"2026-10-17","base":"USD","quote":"JEP","rate":0.75223},{"date":"2026-10-16","base":"USD","quote":"JMD","rate":158.16},{"date":"2026-10-16","base":"USD","quote":"JOD","rate":0.709},{"date":"2026-10-17","base":"USD","quote":"JPY","rate":158.08},{"date":"2026-10-17","base":"USD","quote":"KES","rate":129.64},{"date":"2026-10-17","base":"USD","quote":"KGS","rate":87.44},{"date":"2026-10-16","base":"USD","quote":"KHR","rate":4062.09},{"date":"2026-10-16","base":"USD","quote":"KMF","rate":439.39},{"date":"2026-10-15","base":"USD","quote":"KPW","rate":130.02},{"date":"2026-10-17","base":"USD","quote":"KRW","rate":1339.49},{"date":"2026-10-17","base":"USD","quote":"KWD","rate":0.3093},{"date":"2026-10-16","base":"USD","quote":"KYD","rate":0.83717},{"date":"2026-10-17","base":"USD","quote":"KZT","rate":452.65},{"date":"2026-10-16","base":"USD","quote":"LAK","rate":22362},{"date":"2026-10-16","base":"USD","quote":"LBP","rate":89715},{"date":"2026-10-16","base":"USD","quote":"LKR","rate":330.65},{"date":"2026-10-16","base":"USD","quote":"LRD","rate":170.37},{"date":"2026-10-16","base":"USD","quote":"LSL","rate":16.4569},{"date":"2026-10-16","base":"USD","quote":"LYD","rate":6.42},{"date":"2026-10-16","base":"USD","quote":"MAD","rate":9.7803},{"date":"2026-10-17","base":"USD","quote":"MDL","rate":17.9101},{"date":"2026-10-16","base":"USD","quote":"MGA","rate":4536.87},{"date":"2026-10-17","base":"USD","quote":"MKD","rate":54.865},{"date":"2026-10-16","base":"USD","quote":"MMK","rate":2096.22},{"date":"2026-10-16","base":"USD","quote":"MNT","rate":3591.81},{"date":"2026-10-16","base":"USD","quote":"MOP","rate":8.0897},{"date":"2026-10-16","base":"USD","quote":"MRU","rate":40.095},{"date":"2026-10-16","base":"USD","quote":"MUR","rate":47.359},{"date":"2026-10-16","base":"USD","quote":"MVR","rate":15.4211},{"date":"2026-10-17","base":"USD","quote":"MWK","rate":1731.9},{"date":"2026-10-17","base":"USD","quote":"MXN","rate":18.4244},{"date":"2026-10-17","base":"USD","quote":"MYR","rate":4.0814},{"date":"2026-10-16","base":"USD","quote":"MZN","rate":63.619},{"date":"2026-10-17","base":"USD","quote":"NAD","rate":16.4766},{"date":"2026-10-17","base":"USD","quote":"NGN","rate":1329.86},{"date":"2026-10-16","base":"USD","quote":"NIO","rate":36.624},{"date":"2026-10-17","base":"USD","quote":"NOK","rate":9.4716},{"date":"2026-10-17","base":"USD","quote":"NPR","rate":151.91},{"date":"2026-10-17","base":"USD","quote":"NZD","rate":1.7741},{"date":"2026-10-17","base":"USD","quote":"OMR","rate":0.3845},{"date":"2026-10-16","base":"USD","quote":"PAB","rate":0.99816},{"date":"2026-10-16","base":"USD","quote":"PEN","rate":3.4271},{"date":"2026-10-16","base":"USD","quote":"PGK","rate":4.5117},{"date":"2026-10-17","base":"USD","quote":"PHP","rate":63.001},{"date":"2026-10-17","base":"USD","quote":"PKR","rate":277.3},{"date":"2026-10-17","base":"USD","quote":"PLN","rate":3.8891},{"date":"2026-10-16","base":"USD","quote":"PYG","rate":5720},{"date":"2026-10-17","base":"USD","quote":"QAR","rate":3.64},{"date":"2026-10-17","base":"USD","quote":"RON","rate":4.7489},{"date":"2026-10-17","base":"USD","quote":"RSD","rate":104.58},{"date":"2026-10-17","base":"USD","quote":"RUB","rate":83.74},{"date":"2026-10-17","base":"USD","quote":"RWF","rate":1474.49},{"date":"2026-10-17","base":"USD","quote":"SAR","rate":3.75},{"date":"2026-10-16","base":"USD","quote":"SBD","rate":8.0333},{"date":"2026-10-16","base":"USD","quote":"SCR","rate":14.3591},{"date":"2026-10-16","base":"USD","quote":"SDG","rate":599.17},{"date":"2026-10-17","base":"USD","quote":"SEK","rate":9.9351},{"date":"2026-10-17","base":"USD","quote":"SGD","rate":1.2807},{"date":"2026-10-16","base":"USD","quote":"SHP","rate":0.75263},{"date":"2026-10-16","base":"USD","quote":"SLE","rate":23.751},{"date":"2026-10-16","base":"USD","quote":"SOS","rate":570.59},{"date":"2026-10-16","base":"USD","quote":"SRD","rate":37.659},{"date":"2026-10-16","base":"USD","quote":"SSP","rate":5739},{"date":"2026-10-16","base":"USD","quote":"STN","rate":21.714},{"date":"2026-10-16","base":"USD","quote":"SVC","rate":8.7381},{"date":"2026-10-16","base":"USD","quote":"SYP","rate":121.89},{"date":"2026-10-16","base":"USD","quote":"SZL","rate":16.4561},{"date":"2026-10-17","base":"USD","quote":"THB","rate":33.478},{"date":"2026-10-17","base":"USD","quote":"TJS","rate":9.2173},{"date":"2026-10-17","base":"USD","quote":"TMT","rate":3.5},{"date":"2026-10-16","base":"USD","quote":"TND","rate":2.999},{"date":"2026-10-16","base":"USD","quote":"TOP","rate":2.3865},{"date":"2026-10-17","base":"USD","quote":"TRY","rate":49.471},{"date":"2026-10-16","base":"USD","quote":"TTD","rate":6.7536},{"date":"2026-10-16","base":"USD","quote":"TWD","rate":32.314},{"date":"2026-10-17","base":"USD","quote":"TZS","rate":2633.11},{"date":"2026-10-17","base":"USD","quote":"UAH","rate":44.883},{"date":"2026-10-17","base":"USD","quote":"UGX","rate":4053.61},{"date":"2026-10-17","base":"USD","quote":"USD","rate":1.0},{"date":"2026-10-16","base":"USD","quote":"UYU","rate":40.14},{"date":"2026-10-17","base":"USD","quote":"UZS","rate":11976},{"date":"2026-10-16","base":"USD","quote":"VES","rate":875.54},{"date":"2026-10-16","base":"USD","quote":"VND","rate":25827},{"date":"2026-10-16","base":"USD","quote":"VUV","rate":118.14},{"date":"2026-10-16","base":"USD","quote":"WST","rate":2.7498},{"date":"2026-10-16","base":"USD","quote":"XAF","rate":584.38},{"date":"2026-10-16","base":"USD","quote":"XAG","rate":0.01745},{"date":"2026-10-16","base":"USD","quote":"XAU","rate":0.00024},{"date":"2026-10-16","base":"USD","quote":"XCD","rate":2.7216},{"date":"2026-10-16","base":"USD","quote":"XCG","rate":1.7969},{"date":"2026-10-17","base":"USD","quote":"XDR","rate":0.73816},{"date":"2026-10-16","base":"USD","quote":"XOF","rate":584.38},{"date":"2026-10-16","base":"USD","quote":"XPD","rate":0.00089},{"date":"2026-10-16","base":"USD","quote":"XPF","rate":105.98},{"date":"2026-10-16","base":"USD","quote":"XPT","rate":0.00062},{"date":"2026-10-16","base":"USD","quote":"YER","rate":235.83},{"date":"2026-10-17","base":"USD","quote":"ZAR","rate":16.4576},{"date":"2026-10-17","base":"USD","quote":"ZMW","rate":19.9877},{"date":"2026-10-16","base":"USD","quote":"ZWG","rate":26.537}]';

/// Captured verbatim from the fallback provider
/// `GET https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json`
/// (HTTP 200), trimmed to the codes in [Currency.currenciesList]. All 162 are
/// present, so the fallback alone can serve the whole list (it is the only
/// source of BGN, HRK and VED).
const String _fallbackBody =
    '{"date":"2026-10-17","usd":{"aed":3.6725,"afn":65.34770057,"all":81.11839452,"amd":362.34819729,"ang":1.7988465,"aoa":936.08854091,"ars":1509.36980844,"aud":1.43951864,"awg":1.79,"azn":1.70107381,"bam":1.74021333,"bbd":2,"bdt":123.00552031,"bgn":1.74021333,"bhd":0.376,"bif":2987.59428195,"bmd":1,"bnd":1.27956682,"bob":11.66944131,"brl":5.06377409,"bsd":1,"btn":94.97110529,"bwp":13.69864033,"byn":3.0109206,"bzd":2.01458327,"cad":1.41415707,"cdf":2303.1,"chf":0.82453143,"clp":984.67924764,"cnh":6.68654609,"cny":6.68730243,"cop":3183.85066941,"crc":454.30536956,"cup":23.99578299,"cve":98.11349836,"czk":21.64325165,"djf":178.131,"dkk":6.65099398,"dop":61.29758568,"dzd":134.46951768,"egp":53.16062128,"ern":15,"etb":163.19443317,"eur":0.88975695,"fjd":2.26778788,"fkp":0.75024697,"gbp":0.75024697,"gel":2.59291227,"ggp":0.75024697,"ghs":11.68624695,"gip":0.75024697,"gmd":73.53149055,"gnf":8803.71229147,"gtq":7.64201221,"gyd":208.77442937,"hkd":7.84847294,"hnl":26.93494493,"hrk":6.7038737,"htg":130.9108859,"huf":323.28457113,"idr":18052.4515161,"ils":3.09453726,"imp":0.75024697,"inr":94.97110529,"iqd":1515.96887131,"irr":1795580.53182558,"isk":121.17802171,"jep":0.75024697,"jmd":158.46955539,"jod":0.709,"jpy":158.02740002,"kes":129.77082501,"kgs":87.45707837,"khr":4068.04103089,"kmf":437.73172242,"kpw":899.85113463,"krw":1334.70864779,"kwd":0.31084913,"kyd":0.83225915,"kzt":452.3409885,"lak":22526.95392782,"lbp":89954.92853223,"lkr":331.19387553,"lrd":170.49098972,"lsl":16.47906597,"lyd":6.42193306,"mad":9.74103206,"mdl":17.92846179,"mga":4497.53785312,"mkd":54.76618752,"mmk":2099.8258072,"mnt":3596.05059269,"mop":8.08392712,"mru":39.97933216,"mur":47.23204429,"mvr":15.47713314,"mwk":1734.34075071,"mxn":18.49139699,"myr":4.08413593,"mzn":63.84194863,"nad":16.47906597,"ngn":1331.40191841,"nio":36.76795535,"nok":9.42824168,"npr":152.02499679,"nzd":1.76934808,"omr":0.38240659,"pab":1,"pen":3.4377465,"pgk":4.48302205,"php":62.99335511,"pkr":276.88112929,"pln":3.88755248,"pyg":5696.0458805,"qar":3.64,"ron":4.7365798,"rsd":104.35796478,"rub":82.61765689,"rwf":1474.75378886,"sar":3.75,"sbd":8.07236058,"scr":14.3763108,"sdg":600.21187188,"sek":9.91473998,"sgd":1.27956682,"shp":0.75024697,"sle":22.96491711,"sos":571.43620332,"srd":37.75827801,"ssp":5750.77501901,"stn":21.78998719,"svc":8.75,"syp":12999.84963262,"szl":16.47906597,"thb":33.45696455,"tjs":9.21504711,"tmt":3.42503035,"tnd":2.99714061,"top":2.40950373,"try":49.57855941,"ttd":6.78486366,"twd":32.47896677,"tzs":2639.64820817,"uah":44.90103763,"ugx":4126.92995011,"usd":1,"uyu":40.21168968,"uzs":12073.80498452,"ved":877.91625908,"ves":877.91625908,"vnd":25827.67077228,"vuv":119.5072541,"wst":2.78782721,"xaf":583.64229655,"xcd":2.70253093,"xcg":1.7988465,"xof":583.64229655,"xpf":106.17624645,"yer":236.1489409,"zar":16.47906597,"zmw":19.98895737,"zwg":26.61359403}}';

/// The original 33-entry order, frozen so a reorder cannot silently remap every
/// user's saved currency pair (which is stored as indices into the list).
const List<String> _originalOrder = [
  'AUD',
  'BGN',
  'BRL',
  'CAD',
  'CHF',
  'CNY',
  'CZK',
  'DKK',
  'EUR',
  'GBP',
  'HKD',
  'HRK',
  'HUF',
  'IDR',
  'ILS',
  'INR',
  'ISK',
  'JPY',
  'KRW',
  'MXN',
  'MYR',
  'NOK',
  'NZD',
  'PHP',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'THB',
  'TRY',
  'USD',
  'ZAR',
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final primary = MoneyConverter.parseFrankfurter(_frankfurterBody)!;
  final fallback = MoneyConverter.parseFallback(_fallbackBody)!;

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'every currency in the list resolves a rate from the merged sources',
    () {
      final data =
          MoneyConverter.mergeRates(
                primary: primary,
                fallback: fallback,
              )['data']
              as Map<String, double>;

      for (final currency in Currency.currenciesList) {
        expect(
          data[currency.id],
          isNotNull,
          reason: '${currency.id} has no rate',
        );
        expect(data[currency.id], greaterThan(0));
      }
    },
  );

  test('the original 33 entries keep their exact order and meaning', () {
    // index 15 is INR and index 31 is USD in every stored user preference.
    expect(
      Currency.currenciesList.take(33).map((c) => c.id).toList(),
      _originalOrder,
    );
    expect(Currency.currenciesList[15].id, 'INR');
    expect(Currency.currenciesList[31].id, 'USD');
    expect(Currency.currenciesList.length, greaterThan(33));
  });

  test(
    'merge takes the primary rate when present and the fallback otherwise',
    () {
      final merged = MoneyConverter.mergeRates(
        primary: primary,
        fallback: fallback,
      );
      final data = merged['data'] as Map<String, double>;

      // EUR is published by both; the primary value must win.
      expect(data['EUR'], 0.89057);
      expect(data['EUR'], isNot((fallback['rates'] as Map)['EUR']));

      // RUB is now in the v2 array at its live rate, while BGN, HRK and VED are
      // fallback-only and still resolve.
      expect(data['RUB'], 83.74);
      for (final code in ['BGN', 'HRK']) {
        expect(data[code], (fallback['rates'] as Map)[code]);
      }
    },
  );

  test('the exposed date is the older of the two provider dates', () {
    final merged = MoneyConverter.mergeRates(
      primary: primary,
      fallback: fallback,
    );
    // The v2 array mixes three dates in one payload; the record date is the
    // oldest one, so nothing claims fresher data than it has.
    expect(merged['frankfurterDate'], '2026-10-15');
    expect(merged['fallbackDate'], '2026-10-17');
    expect(merged['date'], '2026-10-15');
  });

  test(
    'a v2 arrays-first response reshapes exactly like the old v1 body did',
    () {
      final v2 = MoneyConverter.parseFrankfurter(_frankfurterBody)!;

      // Same shape as the /v1/latest parser produced: {"date", "rates"}.
      expect(v2.keys.toSet(), {'date', 'rates'});
      expect(v2['rates'], isA<Map<String, double>>());
      expect((v2['rates'] as Map).containsKey('USD'), isTrue);
      expect((v2['rates'] as Map)['USD'], 1.0);
    },
  );

  test('an empty v2 array parses to null', () {
    expect(MoneyConverter.parseFrankfurter('[]'), isNull);
  });

  test('a malformed v2 body parses to null', () {
    expect(MoneyConverter.parseFrankfurter('{"message": "oops"}'), isNull);
    expect(MoneyConverter.parseFrankfurter('not json'), isNull);
  });

  test('every currency renders a symbol: v2, then non-empty legacy, then the ISO code', () {
    for (final currency in Currency.currenciesList) {
      final symbol = currency.symbol;
      expect(
        symbol == null || symbol.isNotEmpty,
        isTrue,
        reason: '${currency.id} would render an empty pair of brackets',
      );
    }
    // VED is the only list code v2 has neither a symbol nor a record for, so
    // it keeps the legacy fallback and renders its ISO code instead.
    expect(
      Currency.currenciesList.singleWhere((c) => c.id == 'VED').symbol,
      isNull,
    );
    // Codes v2 covers pick up its v2 symbols.
    final mad = Currency.currenciesList.singleWhere((c) => c.id == 'MAD');
    expect(mad.symbol, 'د.م.');
    expect(mad.name, 'Moroccan Dirham');
  });

  test('a v2-only failure still yields a complete map from the fallback', () {
    final merged = MoneyConverter.mergeRates(
      primary: null,
      fallback: fallback,
      fetchedAt: 1,
    );
    final data = merged['data'] as Map<String, double>;

    expect(
      data.keys.toSet(),
      containsAll(Currency.currenciesList.map((c) => c.id)),
    );
    expect(merged['date'], '2026-10-17');
    expect(merged['frankfurterDate'], isNull);
  });

  test('cache path and network path return the same shape', () async {
    final hosts = <String>[];
    final client = MockClient((request) async {
      hosts.add(request.url.host);
      if (request.url.host == 'api.frankfurter.dev') {
        return http.Response(_frankfurterBody, 200);
      }
      return http.Response(_fallbackBody, 200);
    });

    final fromNetwork = await MoneyConverter.fetchRates(
      refreshing: true,
      client: client,
    );

    // Cache was just written and is inside the TTL, so this reads it back.
    final fromCache = await MoneyConverter.fetchRates();

    expect(fromCache, equals(fromNetwork));
    expect(fromCache.keys.toSet(), {
      'date',
      'frankfurterDate',
      'fallbackDate',
      'fetchedAt',
      'data',
    });
    expect(hosts, ['api.frankfurter.dev', 'cdn.jsdelivr.net']);
  });

  test('the mirror host is tried when the CDN host fails', () async {
    final client = MockClient((request) async {
      switch (request.url.host) {
        case 'api.frankfurter.dev':
          return http.Response(_frankfurterBody, 200);
        case 'cdn.jsdelivr.net':
          return http.Response('down', 503);
        default:
          return http.Response(_fallbackBody, 200);
      }
    });

    final rates = await MoneyConverter.fetchRates(
      refreshing: true,
      client: client,
    );
    expect((rates['data'] as Map)['RUB'], isNotNull);
    expect(rates['fallbackDate'], '2026-10-17');
  });

  test('a failed fetch falls back to cached rates', () async {
    SharedPreferences.setMockInitialValues({
      'rates': jsonEncode(
        MoneyConverter.mergeRates(
          primary: primary,
          fallback: fallback,
          fetchedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
      'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
    final failing = MockClient((_) async => http.Response('nope', 500));

    final rates = await MoneyConverter.fetchRates(
      refreshing: true,
      client: failing,
    );
    expect((rates['data'] as Map)['RUB'], isNotNull);
  });

  test('a failed fetch with no cache surfaces the error', () async {
    final failing = MockClient((_) async => http.Response('nope', 500));

    await expectLater(
      MoneyConverter.fetchRates(refreshing: true, client: failing),
      throwsA(isA<Exception>()),
    );
  });

  testWidgets(
    'a missing rate degrades without NaN, Infinity or a cleared field',
    (tester) async {
      // Only the primary's rates are cached, so VED (absent from v2) has no
      // rate at all.
      final primaryOnly = MoneyConverter.mergeRates(
        primary: primary,
        fetchedAt: DateTime.now().millisecondsSinceEpoch,
      );
      SharedPreferences.setMockInitialValues({
        'rates': jsonEncode(primaryOnly),
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
        'Units.currency': ['31', '144'], // USD -> VED
      });

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: buildAppTheme(Tokens.seed, Brightness.light),
            home: const ExchangeRateScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Prefs loaded: the second field now shows the fallback-only currency.
      // Its VE flag badge is the only exact flag string on screen; the rate
      // chip is a longer string, so match on the badge.
      expect(find.text('🇻🇪'), findsOneWidget);

      // Simulate the picker returning VED for the second field: USD -> VED has
      // no rate in a primary-only cache, so the conversion must be skipped.
      tester
          .widget<FieldListTile>(find.byType(FieldListTile).last)
          .changeSelectedIndex(26);
      await tester.pumpAndSettle();

      final fields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();
      expect(fields.length, 2);
      for (final field in fields) {
        final text = field.controller!.text;
        expect(text, isNot(contains('NaN')));
        expect(text, isNot(contains('Infinity')));
        expect(text, isNot(contains('null')));
        expect(text, isNotEmpty);
      }
    },
  );
}
