import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class brokerAd extends StatefulWidget {
  final bool rounded;

  const brokerAd(this.rounded, {Key? key}) : super(key: key);

  @override
  _brokerAdState createState() => _brokerAdState();
}

class _brokerAdState extends State<brokerAd> {

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                borderRadius: widget.rounded == true
                    ? BorderRadius.circular(12.w)
                    : BorderRadius.circular(0.w),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [buttonGradientStart, buttonGradientEnd])),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 17.w, 16.w),
              child: Container(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => SafeArea(child: const WebView(initialUrl: 'https://www.google.com',)),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start trading with our broker partner\nto unlock more signals',
                        style: textButtonStyle,
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        children: [
                          Text(
                            'Trade now',
                            style: TextStyle(
                                color: textDefault,
                                fontSize: 19.sp,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'assets/locker.svg',
                            height: 24.r,
                            width: 24.r,
                          ),
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
