import 'package:crypto_signal_app/pages/alerts/alert_crypto_widget.dart';
import 'package:crypto_signal_app/pages/watchlist/watched_crypto_widget.dart';
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

class AlertEditPage extends StatefulWidget {
  const AlertEditPage({Key? key}) : super(key: key);

  @override
  _AlertEditPageState createState() => _AlertEditPageState();
}

class _AlertEditPageState extends State<AlertEditPage> {
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
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AlertCryptoWidget('btc', true, 32210.93, 0.085000,),
                SizedBox(height: 32.h,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('123'),
                    Text('123'),
                    Spacer(),
                    Text('123'),
                    Text('123'),
                    Text('123'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
