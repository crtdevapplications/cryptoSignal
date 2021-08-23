import 'package:crypto_signal_app/pages/signals/signals_widget.dart';
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

class ShortTermPage extends StatefulWidget {
  const ShortTermPage({Key? key}) : super(key: key);

  @override
  _ShortTermPageState createState() => _ShortTermPageState();
}

class _ShortTermPageState extends State<ShortTermPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Free signal',
                  style: textStyleHeader,
                ),
                CupertinoButton(
                    child: SvgPicture.asset(
                      'assets/questionmark.svg',
                      height: 24.r,
                      width: 24.r,
                      color: bottomNavBarColor,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 15.w,
            ),
            child: SignalsWidget('btc', DateTime.now(), true, 29727.4, 32386.52, 8.95, 40000, 28000),
          ),
          Spacer(),
          brokerAd(false),
        ],
      ),
    );
  }
}
