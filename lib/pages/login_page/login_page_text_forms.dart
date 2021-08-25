import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:phonenumbers_core/core.dart';

import '../../phonecode.dart';

List<String> signUpList = <String>[];
List<String> loginList = <String>[];

Widget buildFirstName() {
  return TextFormField(
    cursorHeight: 22.sp,
    // scrollPadding: EdgeInsets.only(bottom: 200),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
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

Widget buildLastName() {
  return TextFormField(
    cursorHeight: 22.sp,
    decoration: InputDecoration(
      hintText: 'Last Name',
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
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

Widget buildEmail() {
  return TextFormField(
    cursorHeight: 22.sp,
    decoration: InputDecoration(
      hintText: 'Email',
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
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
    onSaved: (String? value) {
      signUpList.add(value.toString());
    },
  );
}

class buildPhoneNumber extends StatefulWidget {
  const buildPhoneNumber({Key? key}) : super(key: key);

  @override
  _buildPhoneNumberState createState() => _buildPhoneNumberState();
}

class _buildPhoneNumberState extends State<buildPhoneNumber> {
  bool correctNumber = false;
  List<String> choosedCountry = ['RU', '+7'];

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          cursorHeight: 22.sp,
          onChanged: (value) async {
            bool? isValid =  await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: value, isoCode: choosedCountry.elementAt(0));
            correctNumber = isValid!;
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Phone',
            contentPadding:
                EdgeInsets.fromLTRB(66.w, 18.h, 18.w, 18.h),
          ),
          validator: (String? value) {
            // bool isValid = PhoneNumber.parse(choosedCountry.elementAt(1)+value!).isValid;
            if (value == null || value.isEmpty) {
              return 'Phone Number is Required';
            }
            if (value.isNotEmpty && !correctNumber) {
              return 'Please enter correct number';
            }
            return null;
          },
          onSaved: (String? value) {
            signUpList.add(value.toString());
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
            child: Container(
              width: 44.w,
              child: Row(
                children: [
                  Image.asset(
                    'assets/flags/' + choosedCountry.elementAt(0).toLowerCase() + '.png',
                    width: 20.r,
                    height: 20.r,
                  ),
                  SvgPicture.asset('assets/dropdown.svg'),
                ],
              ),
            ),
            onPressed: () async {
              choosedCountry = (await showPhonePickerBottomSheet(context))!;
              setState(() {

              });
            },
          ),
        ),
      ],
    );
  }
}

Widget buildLogin() {
  return TextFormField(
    cursorHeight: 22.sp,
    decoration: InputDecoration(
      hintText: 'Login',
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Login Required';
      }
      return null;
    },
    onSaved: (String? value) {
      loginList.add(value.toString());
    },
  );
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
            cursorHeight: 22.sp,
            onSaved: (String? value) {
              loginList.add(value.toString());
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscurePass,
            decoration: InputDecoration(
              hintStyle: textFieldStyle,
              hintText: 'Password',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Password is Required';
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
