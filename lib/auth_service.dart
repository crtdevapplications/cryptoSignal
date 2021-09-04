import 'dart:convert';

import 'package:crypto_signal_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
      notifyListeners();
      return authResult.user!.uid;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      rethrow;
    }
  }

  Future<String> signInWithEmail(String email, String pass) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await getUserData(authResult.user!.uid);
      notifyListeners();
      return authResult.user!.uid;
    } catch (e, s) {
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
      'watched_crypto': user.listOfWatchedCryptos,
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
        listOfWatchedCryptos: mapes["watched_crypto"] as List<String>,
        brokerAdURL: mapes["broker_ad_url"].toString(),
    );
    addUser(appUsr);
    return appUsr;
  }
}

Future<String?> getIP() async {
  try {
    const url = 'https://api.ipify.org';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      print(response.body);
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

String generatePassword({
  bool letter = true,
  bool isNumber = true,
  bool isSpecial = false,
}) {
  const int length = 10;
  const String letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const String letterUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String number = '0123456789';
  const String special = '@#%^*>\$@?/[]=+';

  String chars = '';
  if (letter) chars += '$letterLowerCase$letterUpperCase';
  if (isNumber) chars += number;
  if (isSpecial) chars += special;

  return List.generate(length, (int index) {
    final int indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}
