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
import 'package:crypto_signal_app/pages/watchlist/add_to_watchlist_page.dart';
import 'package:crypto_signal_app/pages/watchlist/watched_crypto_widget.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  late bool temporalBool;

  @override
  void initState() {
    temporalBool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (temporalBool == true) {
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 15.w, top: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your watchlist is currently empty',
              style: textStyleHeader,
            ),
            SizedBox(
              height: 12.h,
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AddToWatchlistPage(),
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
                        'Add crypto to watchlist',
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
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 11.w,),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Watchlist',
                    style: textStyleHeader,
                  ),
                  const Spacer(),
                  CupertinoButton(
                    child: Container(
                      color: Colors.transparent,
                      child: SvgPicture.asset('assets/plus.svg', color: Colors.white, height: 24.r,
                        width: 24.r,),
                    ),
                    onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const AddToWatchlistPage(),
                      ),
                    );},
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 16.w, right: 15.w,),
              child: WatchedCryptoWidget('btc', true, 32210.93, 0.085000,),
            ),
          ],
        ),
      );
    }
  }
}
