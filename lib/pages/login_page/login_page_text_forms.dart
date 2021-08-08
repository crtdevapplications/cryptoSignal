import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';

class UserAcc {
  UserAcc(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneCode,
      required this.phoneNumber});

  String firstName;
  String lastName;
  String email;
  String phoneCode;
  String phoneNumber;
}

Widget buildFirstName() {
  return TextFormField(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
      hintText: 'First Name',
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'First Name is Required';
      }
      return null;
    },
  );
}

Widget buildLastName() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Last Name',
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Last Name is Required';
      }
      return null;
    },
  );
}

Widget buildEmail() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Email',
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is Required';
      }
      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email Address';
      }
      return null;
    },
  );
}

Widget buildPhoneNumber() {
  return TextFormField(
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      hintText: 'Phone',
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Phone Number is Required';
      }
      return null;
    },
  );
}

Widget buildLogin() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Login',
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Login Required';
      }
      return null;
    },
  );
}

Widget buildPassword() {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: EdgeInsets.symmetric(vertical: 21.w, horizontal: 21.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is Required';
      }
      return null;
    },
  );
}
