import 'dart:async';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class brokerAd extends StatefulWidget {
  final bool rounded;
  final String url;

  const brokerAd(this.rounded, this.url, {Key? key}) : super(key: key);

  @override
  _brokerAdState createState() => _brokerAdState();
}

class _brokerAdState extends State<brokerAd> {
  late InAppWebViewController controllerGlobal;

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
              FirebaseAnalytics()
                  .logEvent(name: 'broker_widget_pressed', parameters: null);
              Amplitude.getInstance(instanceName: "crypto-signal").logEvent('broker_widget_pressed');
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => Theme(
                    data: appThemeData,
                    child: WillPopScope(
                      onWillPop: () => _willPopCallback(),
                      child: Scaffold(
                          appBar: AppBar(
                            actions: [
                              Transform.rotate(
                                angle: 150,
                                child: Container(
                                  // height: 24.r,
                                  // width: 24.r,
                                  child: CupertinoButton(
                                    child: SvgPicture.asset(
                                      'assets/white_plus.svg',
                                      height: 26.r,
                                      width: 26.r,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              )
                            ],
                            elevation: 0,
                            brightness: Brightness.dark,
                            backgroundColor:
                                const Color.fromRGBO(20, 20, 34, 1),
                            titleSpacing: 0,
                          ),
                          body: SafeArea(child: InAppWebView(
                            onWebViewCreated: (controlller) {
                              controllerGlobal = controlller;
                            },
                            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                          )
                              //     WebView(
                              //   initialUrl: widget.url,
                              //   onWebViewCreated: (controlller) {
                              //     controllerGlobal = controlller;
                              //   },
                              //   javascriptMode: JavascriptMode.unrestricted,
                              // )
                              )),
                    ),
                  ),
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
                SizedBox(
                  height: 2.h,
                ),
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

  Future<bool> _willPopCallback() async {
    bool canNavigate = await controllerGlobal.canGoBack();
    if (canNavigate) {
      controllerGlobal.goBack();
      return false;
    } else {
      return true;
    }
  }
}
