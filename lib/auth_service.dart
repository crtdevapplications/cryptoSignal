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
      'date_time': user.dateTime
    });
  }

  Future? getUserData(String uid) async {
    var snapshot = await userCollection.doc(uid).get();
    Object? objectFromFirestore = snapshot.data();
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
  bool isSpecial = true,
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
