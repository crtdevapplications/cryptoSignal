import 'package:crypto_signal_app/pages/alerts/alert_crypto_widget.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/pages/signals/signals_widget.dart';
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
import 'package:hive/hive.dart';

import '../../background_widget.dart';
import '../../user.dart';

class SignalDetails extends StatefulWidget {
  Signal signal;
  String status;

  SignalDetails(this.signal, this.status, {Key? key}) : super(key: key);

  @override
  _SignalDetailsState createState() => _SignalDetailsState();
}

class _SignalDetailsState extends State<SignalDetails> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Background_Widget(
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            brightness: Brightness.dark,
            actions: [
              // CupertinoButton(
              //     child: SvgPicture.asset(
              //       'assets/bell.svg',
              //       color: Colors.white,
              //       height: 24.r,
              //       width: 24.r,
              //     ),
              //     onPressed: (){
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute<void>(
              //           builder: (context) => const NotificationPage(),
              //         ),
              //       );
              //     })
            ],
            title: Text(
              'Signal details',
              style: textStyleHeader,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 22.h,
                    ),
                    widget.status.toLowerCase() == 'open'
                        ? SignalsWidget(
                            widget.signal, widget.status, false, false)
                        : AlertCryptoWidget(widget.signal),
                    SizedBox(
                      height: 32.h,
                    ),
                    Container(
                      height: 72.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
                      decoration: BoxDecoration(
                          color: cardBackground,
                          borderRadius: BorderRadius.circular(16.w)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: textButtonStyle,
                          ),
                          Spacer(),
                          // if (true)
                          Text(
                            widget.status.toUpperCase(),
                            style: textStyleHeader,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      height: 72.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
                      decoration: BoxDecoration(
                          color: cardBackground,
                          borderRadius: BorderRadius.circular(16.w)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total gain',
                            style: textButtonStyle,
                          ),
                          Spacer(),
                          if (widget.status.toLowerCase() == 'open')
                            Text(
                              totalSignalGain + '%',
                              style: totalSignalGain.contains('-') == false
                                  ? textStyleHeaderGreen
                                  : textStyleHeaderRed,
                            )
                          else
                            Text(
                              widget.signal.percentChange!.toStringAsFixed(2)+ '%',
                              style: widget.signal.gain == true
                                  ? textStyleHeaderGreen
                                  : textStyleHeaderRed,
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      'Your are always granted access to one FREE open signal',
                      style: richTextRegular,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    brokerAd(true,
                        Hive.box<AppUser>('appuser').values.first.brokerAdURL),
                    SizedBox(
                      height: 32.h,
                    ),
                    widget.status.toLowerCase() == 'open'
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SignalsWidget(
                                  widget.signal, widget.status, false, true),
                              SizedBox(
                                height: 32.h,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
