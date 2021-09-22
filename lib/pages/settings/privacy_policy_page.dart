import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/background_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  @override
  void initState() {
    FirebaseAnalytics().logEvent(name: 'privacy_policy_page_opened', parameters: null);
    Amplitude.getInstance(instanceName: "crypto-signal").logEvent('privacy_policy_page_opened');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Background_Widget(
        Scaffold(
          appBar: AppBar(
            title:  Text('Privacy Policy', style: textStyleHeader,),
            elevation: 0,
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            titleSpacing: 0,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.w, top: 2.h),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(style: textStyleWhite, children: [
                        TextSpan(text: privacyAndPolicyText),
                      ])),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
