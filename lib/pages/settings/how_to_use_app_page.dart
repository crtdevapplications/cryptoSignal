import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HowToUseAppPage extends StatefulWidget {
  const HowToUseAppPage({Key? key}) : super(key: key);

  @override
  _HowToUseAppPageState createState() => _HowToUseAppPageState();
}

class _HowToUseAppPageState extends State<HowToUseAppPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Theme(
          data: appThemeData,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
            appBar: AppBar(
              title: Text(
                'How to use app',
                style: textStyleHeader,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 36.h, bottom: 12.h),
                              child: Image.asset('assets/howtouseappimages/howtouseapp2.png'),
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextHeader, children: [
                                  TextSpan(text: '1. Receive buy signal push notification'),
                                ])),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextRegular, children: [
                                  const TextSpan(
                                      text:
                                          'Our team of experienced crypto traders analyzes the crypto market. Out signals are also analyzed with expert advisors. Make sure to enable the notification. so you can receive real-time BUY crypto signals'),
                                ])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 36.h, bottom: 12.h),
                              child: Image.asset('assets/howtouseappimages/howtouseapp2.png'),
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextHeader, children: [
                                  TextSpan(text: '2. Place buy order'),
                                ])),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextRegular, children: [
                                  const TextSpan(
                                      text:
                                          'Once you receive the crypto signal, go to the order menu with your borker. Then buy the crypto using the details from the signal that you received'),
                                ])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 36.h, bottom: 12.h),
                              child: Image.asset('assets/howtouseappimages/howtouseapp3.png'),
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextHeader, children: [
                                  TextSpan(text: '3. Place sell order'),
                                ])),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextRegular, children: [
                                  const TextSpan(
                                      text:
                                          'From the order menu, you can also open a seller order. Open the order menu on your broker and execute the order using the signal details'),
                                ])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 36.h, bottom: 12.h),
                              child: Image.asset('assets/howtouseappimages/howtouseapp3.png'),
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextHeader, children: [
                                  TextSpan(text: '4. Wait if out!'),
                                ])),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(style: richTextRegular, children: [
                                  const TextSpan(
                                      text:
                                          'Once your order is executed, the signal can take several days to reach the target. We will update you by sending notifications about the current crypto signal'),
                                ])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 72.w,
                  height: 12.h,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: toggleButtonStyle,
                    indicatorWeight: 0,
                    labelPadding: EdgeInsets.zero,
                    labelColor: textBlack,
                    indicator: const BoxDecoration(color: Color.fromRGBO(196, 196, 196, 1), shape: BoxShape.circle),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(196, 196, 196, 0.2)),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(196, 196, 196, 0.2)),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(196, 196, 196, 0.2)),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(196, 196, 196, 0.2)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 16.h
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 52.h,
                    child: CupertinoButton(
                        child: Text(
                          'Start trading',
                          style: textButtonStyle,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {}),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.w),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          buttonGradientStart,
                          buttonGradientEnd,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
