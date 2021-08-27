import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';


class brokerAd extends StatefulWidget {
  final bool rounded;
  const brokerAd(this.rounded, {Key? key}) : super(key: key);

  @override
  _brokerAdState createState() => _brokerAdState();
}

class _brokerAdState extends State<brokerAd> {
  bool showAd = true;
  @override
  Widget build(BuildContext context) {
    return showAd == false ? Container() :  Container(
      decoration: BoxDecoration(
          borderRadius: widget.rounded == true ? BorderRadius.circular(12.w) : BorderRadius.circular(0.w),
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [buttonGradientStart, buttonGradientEnd])),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 17.w, 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start trading with our broker partner\nto unlock more signals',
              style: textButtonStyle,
            ),
            CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Text(
                    'Trade now',
                    style: TextStyle(color: textDefault, fontSize: 19.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/locker.svg',
                    height: 24.r,
                    width: 24.r,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
