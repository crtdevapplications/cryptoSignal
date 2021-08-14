import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';
import 'package:crypto_signal_app/pages/settings/calculate_gain_page.dart';

class SignalsPage extends StatefulWidget {
  const SignalsPage({Key? key}) : super(key: key);

  @override
  _SignalsPageState createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  late bool temporalBool;

  @override
  void initState() {
    temporalBool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 15.w, top: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Good evening Elon', style: textStyleHeader),
            ],
          ),
    );
  }
}
