import 'dart:convert';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'alert_service.dart';
import 'constants.dart';

class AuthService extends ChangeNotifier {
  bool get isSignedIn => _auth.currentUser != null;
  bool isLoading = false;
  late String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get firebaseUser {
    return _auth.authStateChanges();
  }

  Future<String> registerWithEmail(String email, String pass) async {
    try {
      isLoading = true;
      notifyListeners();
      final UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      isLoading = false;
      notifyListeners();
      FirebaseAnalytics()
          .logEvent(name: 'new_account_created', parameters: null);
      Amplitude.getInstance(instanceName: "crypto-signal").logEvent('new_account_created');
      return authResult.user!.uid;

    }
    on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      rethrow;
    }
    catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void notifyListenersIfUserIsAdded() {
    if (isSignedIn) {
      notifyListeners();
    }
  }
  void switchIsLoading(bool newValue) {
      isLoading = newValue;
      notifyListeners();
  }

  Future<String> signInWithEmail(String email, String pass) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await getUserData(authResult.user!.uid);
      notifyListeners();
      FirebaseAnalytics()
          .logEvent(name: 'user_logged_in', parameters: null);
      Amplitude.getInstance(instanceName: "crypto-signal").logEvent('user_logged_in');
      return authResult.user!.uid;
    }
    on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      FirebaseAnalytics()
          .logEvent(name: 'user_failed_to_login', parameters: null);
      Amplitude.getInstance(instanceName: "crypto-signal").logEvent('user_failed_to_login');
      rethrow;
    }
    catch (e, s) {
      isLoading = false;
      notifyListeners();
      FirebaseCrashlytics.instance.recordError(e, s);
      rethrow;
    }
  }

  Future? updateUserData(AppUser user, String uid) async {
    return await userCollection.doc(uid).set({
      'first_name': user.firstName,
      'last_name': user.lastName,
      'email': user.email,
      'password': user.password,
      'country_phone_code': user.countryPhoneCode,
      'phone_number': user.phoneNumber,
      'country_ISO': user.countryISO,
      'lead_IP': user.leadIP,
      'land_domain': user.landDomain,
      'affiliate_ID': user.affiliateID,
      'offer_ID': user.offerID,
      'date_time': user.dateTime,
      // добавляет список watched крипт на фаерстор
      // 'watched_crypto': user.listOfWatchedCryptos,
      'broker_ad_url': user.brokerAdURL
    });
  }

  Future<AppUser> getUserData(String uid) async {
    var snapshot = await userCollection.doc(uid).get();
    var object = snapshot.data();
    Map<String, dynamic> mapes = object as Map<String, dynamic>;
    AppUser appUsr = AppUser(
      firstName: mapes["first_name"].toString(),
      lastName: mapes["last_name"].toString(),
      email: mapes["email"].toString(),
      password: mapes["password"].toString(),
      countryPhoneCode: mapes["country_phone_code"].toString(),
      phoneNumber: mapes["phone_number"].toString(),
      countryISO: mapes["country_ISO"].toString(),
      leadIP: mapes["lead_IP"].toString(),
      landDomain: mapes["land_domain"].toString(),
      affiliateID: mapes["affiliate_ID"].toString(),
      offerID: mapes["offer_ID"].toString(),
      dateTime: mapes["date_time"].toDate() as DateTime,
      uid: uid,
      //вытягивает список watched крипт с фаерстора, поскольку их теперь нет, записывает пустую строку
      // listOfWatchedCryptos: mapes["watched_crypto"] as List<String>,
      listOfWatchedCryptos: <String>[],
      listOfAlertCryptos: <Alert>[],
      brokerAdURL: mapes["broker_ad_url"].toString(),
    );
    addUser(appUsr);
    return appUsr;
  }


Future<String?> getIP() async {
  isLoading = true;
  notifyListeners();
  try {
    const url = 'https://api.ipify.org';
    var ipResponse = await http.get(Uri.parse(url));
    if (ipResponse.statusCode == 200) {
      return ipResponse.body;
    } else {
      print(ipResponse.statusCode);
      print(ipResponse.body);
      isLoading = false;
      notifyListeners();
      return null;
    }
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
    print(e);
    isLoading = false;
    notifyListeners();
    return null;
  }
}
}
String generatePassword(bool _isWithLetters, bool _isWithUppercase,
    bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {

  String _lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
  String _upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String _numbers = '0123456789';
  String _special = '@#=+!£\$%&?[](){}';

  String _allowedChars = '';
  _allowedChars += _isWithLetters ? _lowerCaseLetters : '';
  _allowedChars += _isWithUppercase ? _upperCaseLetters : '';
  _allowedChars += _isWithNumbers ? _numbers : '';
  _allowedChars += _isWithSpecial ? _special : '';

  int i = 0;
  String _result = '';
  while (i < _numberCharPassword.round()) {
    int randomInt = Random.secure().nextInt(_allowedChars.length);
    _result += _allowedChars[randomInt];
    i++;
  }
  _result += _numbers[Random().nextInt(_numbers.length)];
  _result += _upperCaseLetters[Random().nextInt(_upperCaseLetters.length)];
  _result += _lowerCaseLetters[Random().nextInt(_lowerCaseLetters.length)];
  return _result;
}
