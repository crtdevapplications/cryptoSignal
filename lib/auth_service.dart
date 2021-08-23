import 'package:crypto_signal_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthService {
  late String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Stream<User?> get firebaseUser {
    return _auth.authStateChanges();
  }


  Future<String> registerWithEmail(String email, String pass) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return authResult.user!.uid;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
  Future signInWithEmail(String email, String pass) async{
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future? updateUserData(AppUser user, String uid) async {

    return await userCollection.doc(uid).set({
      'first name': user.firstName,
      'last name': user.lastName,
      'email': user.email,
      'password': user.password,
      'country phone code': user.countryPhoneCode,
      'phone number': user.phoneNumber,
      'country ISO': user.countryISO,
      'lead IP': user.leadIP,
      'land domain': user.landDomain,
      'affiliate ID': user.affiliateID,
      'offer ID': user.offerID,
      'date time': user.dateTime
    });
  }

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  })  {
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

}
