import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/onboarding.dart';
import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/remote_config_service.dart';
import 'dart:convert';
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/user_preference.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/pages/login_page/login_page.dart';
import 'package:crypto_signal_app/pages/settings/settings_page.dart';
import 'package:crypto_signal_app/pages/watchlist/watchlist_page.dart';
import 'package:crypto_signal_app/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:hive/hive.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class CryptoApi {
  String symbol;
  double currentPrice;
  bool gain;
  String percentChange;

  CryptoApi(
      {required this.symbol,
      required this.currentPrice,
      required this.gain,
      required this.percentChange});
}

// Future<List<CryptoApi>> getCryptosFromApi(List<String> list) async {
//   try {
//     http.Response response = await http
//         .get(Uri.parse(apiCryptoUrl + list.join(',')), headers: <String, String>{
//       'X-CMC_PRO_API_KEY': apiKey,
//       'Accept': 'application/json',
//     });
//     if (response.statusCode == 200) {
//       var cryptosData = jsonDecode(response.body) as Map<String, dynamic>;
//       List<CryptoApi> listOfCryptos = [];
//       (cryptosData['data'].values).forEach((dynamic item) {
//         var record = CryptoApi(
//             symbol: item['symbol'].toString(),
//             currentPrice: double.parse(item['quote']['USD']['price'].toString()),
//             gain: item['quote']['USD']['percent_change_24h'].toString().contains('-') ? false : true,
//             percentChange: item['quote']['USD']['percent_change_24h'].toString());
//         listOfCryptos.add(record);
//       });
//       return listOfCryptos;
//     } else {
//       throw Exception('Server returned non 200 response');
//     }
//   } catch (e, s) {
//     FirebaseCrashlytics.instance.recordError(e, s);
//     rethrow;
//   }
// }
Future<List<CryptoApi>> getCryptosFromById(List<String> list) async {
  List<String?> actualList = [];
  for(int i = 0; i<list.length; i++)
  {
    if(listOfCryptos.containsKey(list[i])){
      actualList.add(listOfCryptos[list[i]]!.toLowerCase());
    }
  }
  // print(actualList);
  try {
    http.Response response = await http
        .get(Uri.parse(apiCryptoUrl1 + actualList.join(',') + apiCryptoUrlSuffix), headers: <String, String>{
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var cryptosData = jsonDecode(response.body) as List<dynamic>;
      List<CryptoApi> listOfCryptos = [];
      (cryptosData).forEach((dynamic item) {
        var record = CryptoApi(
            symbol: item['symbol'].toString(),
            currentPrice: double.parse(item['current_price'].toString()),
            gain: item['price_change_percentage_24h'].toString().contains('-') ? false : true,
            percentChange: item['price_change_percentage_24h'].toString());
        listOfCryptos.add(record);
      });
      return listOfCryptos;
    } else {
      throw Exception('Server returned non 200 response');
    }
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    rethrow;
  }
}
Future<List<CryptoApi>> getASingleCrypto(String crypto) async {

  try {
    http.Response response = await http
        .get(Uri.parse(apiCryptoUrl1 + crypto + apiCryptoUrlSuffix), headers: <String, String>{
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var cryptosData = jsonDecode(response.body) as List<dynamic>;
      List<CryptoApi> listOfCryptos = [];
      (cryptosData).forEach((dynamic item) {
        var record = CryptoApi(
            symbol: item['symbol'].toString(),
            currentPrice: double.parse(item['current_price'].toString()),
            gain: item['price_change_percentage_24h'].toString().contains('-') ? false : true,
            percentChange: item['price_change_percentage_24h'].toString());
        listOfCryptos.add(record);
      });
      return listOfCryptos;
    } else {
      throw Exception('Server returned non 200 response');
    }
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    rethrow;
  }
}
Future<List<CryptoApi>> getCryptosFromByName(List<String> actualList) async {
  try {
    http.Response response = await http
        .get(Uri.parse(apiCryptoUrl1 + actualList.join(',') + apiCryptoUrlSuffix), headers: <String, String>{
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var cryptosData = jsonDecode(response.body) as List<dynamic>;
      List<CryptoApi> listOfCryptos = [];
      (cryptosData).forEach((dynamic item) {
        var record = CryptoApi(
            symbol: item['symbol'].toString(),
            currentPrice: double.parse(item['current_price'].toString()),
            gain: item['price_change_percentage_24h'].toString().contains('-') ? false : true,
            percentChange: item['price_change_percentage_24h'].toString());
        listOfCryptos.add(record);
      });
      return listOfCryptos;
    } else {
      throw Exception('Server returned non 200 response');
    }
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    rethrow;
  }
}
