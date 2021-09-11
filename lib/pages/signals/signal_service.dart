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

part 'signal_service.g.dart';

List<Signal> listOfOpenSignals = [];
List<Signal> listOfClosedSignals = [];

@HiveType(typeId: 3)
class Signal {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? symbol;
  @HiveField(2)
  double? entryPrice;
  @HiveField(3)
  double? currentPrice;
  @HiveField(4)
  double? takeProfit;
  @HiveField(5)
  double? stopLoss;
  @HiveField(6)
  DateTime? dateAdded;
  @HiveField(7)
  double? percentChange;
  @HiveField(8)
  bool? gain;
  @HiveField(9)
  String? type;
  @HiveField(10)
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
  addSignals(listOfOpenSignals, 0);
  addSignals(listOfClosedSignals, 1);
  fillTheLists();
}

void addSignals(List <Signal> signals, int id) {
  final Box<List <Signal>> userBox = Hive.box<List<Signal>>('signals');
  userBox.put(id, signals);
}
void fillTheLists(){
  listOfFilteredOpenSignals.addAll(Hive.box<List <Signal>>('signals').toMap()[0]!.toList());
  listOfFilteredClosedSignals.addAll(Hive.box<List <Signal>>('signals').toMap()[1]!.toList());
}

