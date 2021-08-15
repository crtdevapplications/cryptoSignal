import 'package:crypto_signal_app/pages/alerts/alert_edit_page.dart';
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

import 'add_to_alerts_page.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late bool temporalBool;
  late bool anotherBool;
  @override
  void initState() {
    temporalBool = false;
    anotherBool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 38.h,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 11.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Active', style: textStyleHeader),
                  Spacer(),
                  if (temporalBool == false)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          child: Container(
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              'assets/plus.svg',
                              color: Colors.white,
                              height: 24.r,
                              width: 24.r,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const AddToAlertsPage(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),
                        CupertinoButton(
                          child: Container(
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              'assets/edit.svg',
                              color: Colors.white,
                              height: 24.r,
                              width: 24.r,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const AlertEditPage(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          if (temporalBool == false)
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 15.w,
              ),
              child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const AddToAlertsPage(),
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                child: Container(
                  height: 52.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [buttonGradientStart, buttonGradientEnd]),
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'New alert',
                          style: textButtonStyle,
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/plus.svg',
                          height: 24.r,
                          width: 24.r,
                          color: svgPicturesColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 32.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 15.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Past',
                  style: textStyleHeader,
                ),
                SizedBox(
                  height: 12.h,
                ),
                if(anotherBool == false)
                Text(
                  'You dont have past alert',
                  style: textStyleWhite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
