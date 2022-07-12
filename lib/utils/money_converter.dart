import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/currency.dart';

class MoneyConverter {
  // static const MethodChannel _channel = MethodChannel('money_converter');

  static Future<dynamic> convert(Currency from, Currency to) async {
    try {
      if (from.type.isEmpty || to.type.isEmpty) {
        log("type or ammount is missing");
        return null;
      }

      from.amount ??= 1.0;
      String url =
          "${_Controller.endPoint}q=${from.type}_${to.type}&${_Controller.apiKey}&${_Controller.compact}";

      http.Response resp = (await _Controller.getMoney(url))!;
      log(resp.body);

      double unitValue = jsonDecode(resp.body)['${from.type}_${to.type}'];

      double value = from.amount! * unitValue;

      return value;
    } catch (err) {
      log("convert err $err");
      return 0.0;
    }
  }
}

class _Controller {
  // url
  static const String endPoint = "https://free.currconv.com/api/v7/convert?";
  static const String compact = "compact=ultra";
  // secret key
  static const String apiKey = "apiKey=5110ee6993edd226b853";

// get money function used for call api and return value
  static Future<http.Response?> getMoney(url) async {
    try {
      log(url);
//cal api
      final response = await http.get(Uri.parse(url));
// get response
      return response;
    } catch (e) {
// catch er
      log("fetch get err $e");
    }
    return null;
  }
}
