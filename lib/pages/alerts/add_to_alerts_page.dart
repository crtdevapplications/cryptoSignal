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

class AddToAlertsPage extends StatefulWidget {
  const AddToAlertsPage({Key? key}) : super(key: key);

  @override
  _AddToAlertsPageState createState() => _AddToAlertsPageState();
}

class _AddToAlertsPageState extends State<AddToAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        appBar: AppBar(
          title: Text(
            'New alert',
            style: textStyleHeader,
          ),
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: Text('el puk'),
        ),
      ),
    );
  }
}
