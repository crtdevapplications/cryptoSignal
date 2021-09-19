import 'dart:convert';

import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BrokerAdService {
  Future<String?> registerNewUser(AppUser appUser, AuthService authService) async {
    authService.switchIsLoading(true);
    try {
      Map<String, dynamic> body = <String, dynamic>{
        'first_name': appUser.firstName,
        'last_name': appUser.lastName,
        'email': appUser.email,
        'password': appUser.password,
        'phonecc': appUser.countryPhoneCode,
        'phone': appUser.phoneNumber,
        'country': appUser.countryISO,
        'user_ip': appUser.leadIP,
        'aff_sub3': 'domain.com',
        'aff_id': appUser.affiliateID,
        'offer_id': appUser.offerID,
      };
      // String jsonBody = json.encode(body);
      var response = await http.post(
        Uri.parse(apiBrokerUrl),
        body: body,
        encoding: Encoding.getByName('utf-8'),
        headers: <String, String>{
          'Accept': 'application/json',
        },
      );
      if(response.statusCode == 302){
        if (response.headers.containsKey("location")){
          final getResponse = await http.get(Uri.parse((response.headers["location"])!));
          if(getResponse.statusCode == 200){
            print('Succed');
            Map<String, dynamic> mapes = jsonDecode(getResponse.body) as Map<String, dynamic>;
            print(mapes["redirect"].toString());
            return mapes["redirect"].toString();
          }
          else{
            print('2Status code ' + response.statusCode.toString());
            print('2Response body ' + response.body);
            print('2Headers ' + response.headers.toString());
            authService.switchIsLoading(false);
            return 'wrong';
          }
        }
      }
      else {
        print('Status code ' + response.statusCode.toString());
        print('Response body ' + response.body);
        print('Headers ' + response.headers.toString());
        authService.switchIsLoading(false);
        return 'wrong';
      }
    } catch (e, s) {
      print(e);
      FirebaseCrashlytics.instance.recordError(e, s);
      authService.switchIsLoading(false);
      return 'wrong';
    }
  }
}
