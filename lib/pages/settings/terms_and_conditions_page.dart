import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Terms and Conditions', style: textStyleHeader,),
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,

        ),
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.w, top: 2.h),
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(style: textStyleWhite, children: [
                      TextSpan(text: termsAndConditionsText),
                    ])),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
