import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:libphonenumber/libphonenumber.dart';

import '../../phonecode.dart';

List<String> signUpList = <String>[];
List<String> loginList = <String>[];
List<String> choosedCountry = ['RU', '+7'];

class buildFirstName extends StatefulWidget {
  const buildFirstName({Key? key}) : super(key: key);

  @override
  _buildFirstNameState createState() => _buildFirstNameState();
}

class _buildFirstNameState extends State<buildFirstName> {
  @override

  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
        hintText: 'First Name',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'First Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        signUpList.add(value.toString());
      },
    );
  }
}

class buildLastName extends StatefulWidget {
  const buildLastName({Key? key}) : super(key: key);

  @override
  _buildLastNameState createState() => _buildLastNameState();
}

class _buildLastNameState extends State<buildLastName> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // cursorHeight: 22.sp,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Last Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        signUpList.add(value.toString());
      },
    );
  }
}

class buildEmail extends StatefulWidget {
  const buildEmail({Key? key}) : super(key: key);

  @override
  _buildEmailState createState() => _buildEmailState();
}

class _buildEmailState extends State<buildEmail> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      // cursorHeight: 22.sp,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
      ),
      onChanged: (value){
        correctCredentials = true;
      },

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Email is Required';
        }
        if (correctCredentials == false){
          return 'Email already in use';
        }
        if (!emailRegExp.hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (String? value) {
        signUpList.add(value.toString());
      },
    );
  }
}

class buildPhoneNumber extends StatefulWidget {
  const buildPhoneNumber({Key? key}) : super(key: key);

  @override
  _buildPhoneNumberState createState() => _buildPhoneNumberState();
}

class _buildPhoneNumberState extends State<buildPhoneNumber> {
  bool correctNumber = false;
  String textFieldValue = '';


  @override
  void initState() {
    String userLocale = ui.window.locale.countryCode!;
    if(userLocale.isNotEmpty || userLocale != ''){
      choosedCountry = [userLocale, list.where((element) => element.alpha_2_code == userLocale).first.dial_code];
    }
    super.initState();
  }
  @override
  void setState(VoidCallback fn) async {
    bool? isValid =  await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: textFieldValue, isoCode: choosedCountry.elementAt(0));
    correctNumber = isValid!;
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: (){},
      // cursorHeight: 22.sp,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) async {
        bool? isValid =  await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: value, isoCode: choosedCountry.elementAt(0));
        textFieldValue = value;
        correctNumber = isValid!;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        prefixIcon:   CupertinoButton(
          padding: EdgeInsets.symmetric( horizontal: 15.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(bottom: 2.h),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/flags/' + choosedCountry.elementAt(0).toLowerCase() + '.png',
                      width: 20.r,
                    ),
                    SvgPicture.asset('assets/dropdown.svg'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(choosedCountry.elementAt(1).toLowerCase(), style: textButtonStyle,),
              )
            ],
          ),
          onPressed: () async {
            List<String>? choosedCountryTest = await showPhonePickerBottomSheet(context);
            if(choosedCountryTest != null){
              choosedCountry = choosedCountryTest;
            }
            setState(() {
            });
          },
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 20.r,
          minHeight: 20.r,
        ),
        hintText: 'Phone',
        contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
      ),
      validator: (String? value) {
        // bool isValid = PhoneNumber.parse(choosedCountry.elementAt(1)+value!).isValid;
        if (value == null || value.isEmpty) {
          return 'Phone Number is Required';
        }
        if (value.isNotEmpty && !correctNumber) {
          return 'Please enter a valid number';
        }
        if (!numberRegExp.hasMatch(value)) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (String? value) {
        signUpList.add(value.toString());
      },
    );
  }
}

class buildLogin extends StatefulWidget {
  const buildLogin({Key? key}) : super(key: key);

  @override
  _buildLoginState createState() => _buildLoginState();
}

class _buildLoginState extends State<buildLogin> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      // cursorHeight: 22.sp,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value){
        correctCredentials = true;
      },
      decoration: InputDecoration(
        hintText: 'Login',
        contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Login Required';
        }
        if (correctCredentials == false){
          return 'Incorrect credentials';
        }
        if (!emailRegExp.hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (String? value) {
        loginList.add(value.toString());
      },
    );
  }
}

class buildPassword extends StatefulWidget {
  const buildPassword({Key? key}) : super(key: key);

  @override
  _buildPasswordState createState() => _buildPasswordState();
}

class _buildPasswordState extends State<buildPassword> {
  bool obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          TextFormField(
            // cursorHeight: 22.sp,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (String? value) {
              loginList.add(value.toString());
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscurePass,
            decoration: InputDecoration(
              hintStyle: textFieldStyle,
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(19.r, 19.r,19.r,19.r,),
            ),
            onChanged: (value){
              correctCredentials = true;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Password is Required';
              }
              if (correctCredentials == false){
                return 'Incorrect credentials';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
              child: SvgPicture.asset('assets/passwordeye.svg'),
              onPressed: () {
                setState(() {
                  if (obscurePass == true) {
                    obscurePass = false;
                  } else {
                    obscurePass = true;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
