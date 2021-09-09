import 'dart:convert';
import 'package:crypto_signal_app/alert_service.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

part 'alert_service.g.dart';

@HiveType(typeId: 2)
class Alert {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  bool active;
  @HiveField(2)
  double abovePrice;
  @HiveField(3)
  double belowPrice;
  @HiveField(4)
  bool repeatAlert;

  Alert({
    required this.symbol,
    required this.active,
    required this.abovePrice,
    required this.belowPrice,
    required this.repeatAlert
  });
}