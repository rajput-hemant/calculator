import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyConverter {
  static const String _endPoint = "https://api.freecurrencyapi.com/v1/latest";
  static final String _apiKey = dotenv.env["CURRENCY_API_KEY"]!;

  /// Fetches the exchange rates from the API
  /// and returns a [Future] of the response body
  static Future<dynamic> fetchRates() async {
    final prefs = await SharedPreferences.getInstance();
    const threeHoursInMillis =
        3 * 60 * 60 * 1000; // Three hours in milliseconds

    // If the rates were fetched less than three hours ago,
    // return the saved rates
    if (prefs.containsKey("rates") && prefs.containsKey("lastUpdated")) {
      final savedRates = prefs.getString("rates");
      final lastUpdated = prefs.getInt("lastUpdated");

      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime - lastUpdated! <= threeHoursInMillis) {
        return jsonDecode(savedRates!);
      }
    }

    // Otherwise, fetch the rates from the API
    final response = await http.get(Uri.parse("$_endPoint?apikey=$_apiKey"));
    if (response.statusCode == 200) {
      prefs.setString("rates", response.body);
      prefs.setInt("lastUpdated", DateTime.now().millisecondsSinceEpoch);

      return jsonDecode(response.body).data;
    } else {
      throw Exception("Failed to load rates");
    }
  }
}
