import 'dart:convert';
import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/main.dart';
import 'package:crypto_signal_app/user.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

List<Signal> listOfOpenSignals = [];
List<Signal> listOfClosedSignals = [];

class Signal {
  String? name;
  String? symbol;
  double? entryPrice;
  double? currentPrice;
  double? takeProfit;
  double? stopLoss;
  DateTime? dateAdded;
  double? percentChange;
  bool? gain;
  String? type;
  String? recomendedAction;

  Signal({
    this.name,
    this.symbol,
    this.entryPrice,
    this.currentPrice,
    this.takeProfit,
    this.stopLoss,
    this.dateAdded,
    this.percentChange,
    this.gain,
    this.type,
    this.recomendedAction,
  });

  Signal.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    symbol = json["symbol"]?.toString();
    entryPrice =  double.parse(json['entry_price'].toString());
    currentPrice =double.parse(json['current_price'].toString());
    takeProfit = double.parse(json['take_profit'].toString());
    stopLoss = double.parse(json['stop_loss'].toString());
    dateAdded = DateTime.parse(json['date_added'].toString());
    percentChange = double.parse(json['percent_change'].toString());
    gain = json["gain"] as bool;
    type = json["type"]?.toString();
    recomendedAction = json["recomended_action"]?.toString();
  }
}

void getSignals() {
  // String jsonString = '{     "open": [{             "name": "bitcoin",             "symbol": "BTC",             "entry_price": 29727.4,             "current_price": 33386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "short",             "recomended_action": "buy"         },         {             "name": "dogecoin",             "symbol": "DOGE",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long",             "recomended_action": "buy"         },         {             "name": "ethereum",             "symbol": "ETH",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long",             "recomended_action": "buy"         },          {             "name": "ethereum",             "symbol": "ETH",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long",             "recomended_action": "buy"         }     ],     "closed": [{             "name": "bitcoin",             "symbol": "BTC",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long"         },         {             "name": "dogecoin",             "symbol": "DOGE",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long"         },         {             "name": "ethereum",             "symbol": "ETH",             "entry_price": 29727.4,             "current_price": 32386.52,             "take_profit": 40000,             "stop_loss": 28000,             "date_added": "2021-08-28 19:39:58.320822Z",             "percent_change": 8.95,             "gain": true,             "type": "long"         }     ] }';
  Map<String, dynamic> json = jsonDecode(signalsFromFirestore) as Map<String, dynamic>;
  var record = Signal();
  listOfOpenSignals.clear();
  (json['open']).forEach((dynamic item) {
    record = Signal.fromJson(item as Map<String, dynamic>);
    listOfOpenSignals.add(record);
  });
  listOfClosedSignals.clear();
  (json['closed']).forEach((dynamic item) {
    record = Signal.fromJson(item as Map<String, dynamic>);
    listOfClosedSignals.add(record);
  });
}
