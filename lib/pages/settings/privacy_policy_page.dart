import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(style: textStyleWhite, children: [
                  TextSpan(text: privacyAndPolicyText),
                ])),
          ),
        ),
      ),
    );
  }
}
