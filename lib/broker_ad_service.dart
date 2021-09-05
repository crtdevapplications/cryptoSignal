import 'dart:convert';

import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BrokerAdService {
  Future<String?> registerNewUser(AppUser appUser) async {
    try {
      var response = await http.post(
        Uri.parse(apiBrokerUrl),
        body: {
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
        },
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
            return null;
          }
        }
      }
      else {
        print('Status code ' + response.statusCode.toString());
        print('Response body ' + response.body);
        print('Headers ' + response.headers.toString());
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}