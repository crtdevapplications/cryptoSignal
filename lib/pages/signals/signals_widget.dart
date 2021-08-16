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
import 'package:intl/intl.dart';

class SignalsWidget extends StatefulWidget {
  String cryptoName;
   DateTime date;
   bool goingUp;
   double aboveLimit;
   double belowLimit;
   double entryPrice;
   double currentPrice;
   double percentChange;
  SignalsWidget(this.cryptoName, this.date, this.goingUp, this.entryPrice, this.currentPrice, this.percentChange, this.aboveLimit, this.belowLimit, {Key? key}) : super(key: key);

  @override
  _SignalsWidgetState createState() => _SignalsWidgetState();
}

class _SignalsWidgetState extends State<SignalsWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/cryptoicons/'+widget.cryptoName+'.svg',
                  height: 48.r,
                  width: 48.r,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.cryptoName.toUpperCase()+'/USD',
                            style: textStyleSignalDefault,
                          ),
                          SizedBox(width: 8.w,),
                          if (widget.goingUp == true)
                            Text(
                              widget.percentChange.toString()+'%',
                              style: textStyleSignalGreen,
                            )
                          else
                            Text(
                              '-'+widget.percentChange.toString()+'%',
                              style: textStyleSignalRed,
                            ),
                          Spacer(),
                          if (widget.goingUp == false)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/signalarrowdown.svg',
                                  height: 24.r,
                                  width: 24.r,
                                ),
                                Text(
                                  'SELL',
                                  style: textStyleSignalDefault,
                                ),
                              ],
                            )
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/signalarrowup.svg',
                                  height: 24.r,
                                  width: 24.r,
                                ),
                                Text(
                                  'BUY',
                                  style: textStyleSignalDefault,
                                ),
                              ],
                            ),
                        ],
                      ),
                      Text(
                        DateFormat('dd/M/yy, hh:mm a').format(widget.date),
                        style: textStyleSignalShaded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$'+widget.belowLimit.toString(),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: Color.fromRGBO(255, 91, 91, 1)),
                      ),
                      Spacer(),
                      Text(
                        '\$'+widget.entryPrice.toString(),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: Color.fromRGBO(252, 252, 252, 1)),
                      ),
                      Spacer(),
                      Text(
                        '\$'+widget.currentPrice.toString(),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: Color.fromRGBO(51, 182, 255, 1)),
                      ),
                      Spacer(),
                      Text(
                        '\$'+widget.aboveLimit.toString(),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: Color.fromRGBO(0, 255, 41, 1)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Container(
                        height: 1.h,
                        color: const Color.fromRGBO(196, 196, 196, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 25.w),
                        child: Center(
                          child: Row(
                            children: [
                              Container(
                                height: 8.r,
                                width: 8.r,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: const Color.fromRGBO(255, 91, 91, 1)),
                              ),
                              Spacer(),
                              Container(
                                height: 8.r,
                                width: 8.r,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: const Color.fromRGBO(252, 252, 252, 1)),
                              ),
                              Container(
                                height: 1.h,
                                width: 15.w,
                                color: widget.goingUp == true
                                    ? const Color.fromRGBO(0, 255, 41, 1)
                                    : const Color.fromRGBO(255, 91, 91, 1),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  decoration: BoxDecoration(
                                      color: widget.goingUp == true
                                          ? const Color.fromRGBO(0, 255, 41, 1)
                                          : const Color.fromRGBO(255, 91, 91, 1),
                                      borderRadius: BorderRadius.circular(16.w)),
                                  child: widget.goingUp == true
                                      ? Text(
                                          widget.percentChange.toString()+'\% gain',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromRGBO(73, 75, 87, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'DMSans',
                                          ),
                                        )
                                      : Text(
                                          '-'+widget.percentChange.toString()+'\% loss',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color.fromRGBO(73, 75, 87, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'DMSans',
                                          ),
                                        )),
                              Container(
                                height: 1.h,
                                width: 15.w,
                                color: widget.goingUp == true
                                    ? const Color.fromRGBO(0, 255, 41, 1)
                                    : const Color.fromRGBO(255, 91, 91, 1),
                              ),
                              Container(
                                height: 8.r,
                                width: 8.r,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: const Color.fromRGBO(51, 182, 255, 1)),
                              ),
                              Spacer(),
                              Container(
                                height: 8.r,
                                width: 8.r,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: const Color.fromRGBO(0, 255, 41, 1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stop Loss',
                      style: textStyleSignalWidget,
                    ),
                    Spacer(),
                    Text(
                      'Entry Price',
                      style: textStyleSignalWidget,
                    ),
                    Spacer(),
                    Text(
                      '   Current Price',
                      style: textStyleSignalWidget,
                    ),
                    Spacer(),
                    Text(
                      'Take Profit',
                      style: textStyleSignalWidget,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
