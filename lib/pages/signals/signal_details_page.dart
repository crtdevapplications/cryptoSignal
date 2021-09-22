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
import 'package:intl/intl.dart';

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
                    if (widget.status.toLowerCase() == 'open')
                      Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/cryptoicons/' +
                                widget.signal.symbol!.toLowerCase().toString() +
                                '.svg',
                            height: 48.r,
                            width: 48.r,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.signal.symbol!.toUpperCase() + '/USD',
                                style: textStyleHeader,
                              ),
                              Text(
                                toBeginningOfSentenceCase(tempListOfSignals.last.name).toString() +
                                    '/US Dollar',
                                style: textButtonStyle,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$' +
                                    tempListOfSignals.last.exitPrice
                                        .toString(),
                                style: textButtonStyle,
                              ),
                              Text(
                                getPercentageChange(
                                    (tempListOfSignals
                                        .last.entryPrice)!,
                                    (tempListOfSignals
                                        .last.exitPrice)!)
                                    .toStringAsFixed(2) +
                                    '%',
                                style: tempListOfSignals
                                    .last.gain == true
                                    ? textGainGreen
                                    : textGainRed,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                    else AlertCryptoWidget(widget.signal),
                    SizedBox(
                      height: 32.h,
                    ),
                    Container(
                      height: 72.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 19.h),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 19.h),
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
                              totalGainPerCrypto.entries
                                      .where((element) =>
                                          element.key == widget.signal.name)
                                      .last
                                      .value
                                      .toString() +
                                  '%',
                              style: totalGainPerCrypto.entries
                                          .where((element) =>
                                              element.key == widget.signal.name)
                                          .last
                                          .value
                                          .toString()
                                          .contains('-') ==
                                      false
                                  ? textStyleHeaderGreen
                                  : textStyleHeaderRed,
                            )
                          else
                            Text(
                              widget.signal.percentChange!.toStringAsFixed(2) +
                                  '%',
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
                    if (widget.status.toLowerCase() == 'open') Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
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
                                            'assets/cryptoicons/' +
                                                widget.signal.symbol!
                                                    .toLowerCase()
                                                    .toString() +
                                                '.svg',
                                            height: 44.r,
                                            width: 44.r,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      widget.signal.symbol
                                                          .toString()
                                                          .toUpperCase() +
                                                          '/USD',
                                                      style: TextStyle(
                                                          color: textDefault,
                                                          fontSize:  getPercentageChange(
                                                              (tempListOfSignals
                                                                  .last.entryPrice)!,
                                                              (tempListOfSignals
                                                                  .last.exitPrice)!)
                                                              .toStringAsFixed(2)
                                                              .length >=
                                                              6
                                                              ? 20.sp
                                                              : 22.sp,
                                                          fontFamily: 'DMSans',
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    if (tempListOfSignals
                                                        .last.gain == true)
                                                      Text(
                                                        getPercentageChange(
                                                            (tempListOfSignals
                                                                .last.entryPrice)!,
                                                            (tempListOfSignals
                                                                .last.exitPrice)!)
                                                            .toStringAsFixed(2) +
                                                            '%',
                                                        style: TextStyle(
                                                            color: textGreen,
                                                            fontSize:  getPercentageChange(
                                                                (tempListOfSignals
                                                                    .last.entryPrice)!,
                                                                (tempListOfSignals
                                                                    .last.exitPrice)!)
                                                                .toStringAsFixed(2)
                                                                .length >=
                                                                6
                                                                ? 20.sp
                                                                : 22.sp,
                                                            fontFamily: 'DMSans',
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      )
                                                    else
                                                      Text(
                                                        getPercentageChange(
                                                            (tempListOfSignals
                                                                .last.entryPrice)!,
                                                            (tempListOfSignals
                                                                .last.exitPrice)!)
                                                            .toStringAsFixed(2) +
                                                            '%',
                                                        style: TextStyle(
                                                            color: textRed,
                                                            fontSize:  getPercentageChange(
                                                                (tempListOfSignals
                                                                    .last.entryPrice)!,
                                                                (tempListOfSignals
                                                                    .last.exitPrice)!)
                                                                .toStringAsFixed(2)
                                                                .length >=
                                                                6
                                                                ? 20.sp
                                                                : 22.sp,
                                                            fontFamily: 'DMSans',
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    Spacer(),
                                                    if (widget.signal.recomendedAction!
                                                        .toLowerCase() !=
                                                        'buy')
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/signalarrowdown.svg',
                                                            height: 21.r,
                                                            width: 21.r,
                                                          ),
                                                          Text(
                                                            'SELL',
                                                            style: TextStyle(
                                                                color: textDefault,
                                                                fontSize:  getPercentageChange(
                                                                    (tempListOfSignals
                                                                        .last.entryPrice)!,
                                                                    (tempListOfSignals
                                                                        .last.exitPrice)!)
                                                                    .toStringAsFixed(2)
                                                                    .length >=
                                                                    6
                                                                    ? 20.sp
                                                                    : 22.sp,
                                                                fontFamily: 'DMSans',
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),
                                                        ],
                                                      )
                                                    else
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/signalarrowup.svg',
                                                            height: 21.r,
                                                            width: 21.r,
                                                          ),
                                                          Text(
                                                            'BUY',
                                                            style: TextStyle(
                                                                color: textDefault,
                                                                fontSize:  getPercentageChange(
                                                                    (tempListOfSignals
                                                                        .last.entryPrice)!,
                                                                    (tempListOfSignals
                                                                        .last.exitPrice)!)
                                                                    .toStringAsFixed(2)
                                                                    .length >=
                                                                    6
                                                                    ? 20.sp
                                                                    : 22.sp,
                                                                fontFamily: 'DMSans',
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                                Text(
                                                  DateFormat('dd/M/yy, hh:mm a')
                                                      .format(widget.signal.dateAdded!),
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
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 5.w),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '\$' +
                                                      widget.signal.stopLoss.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'DMSans',
                                                      color: Color.fromRGBO(
                                                          255, 91, 91, 1)),
                                                ),
                                                Spacer(),
                                                if (tempListOfSignals
                                                    .last.gain == true)
                                                  Text(
                                                    '\$' +
                                                        widget.signal.entryPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                        color: Color.fromRGBO(
                                                            252, 252, 252, 1)),
                                                  )
                                                else
                                                  Text(
                                                    '\$' +
                                                        tempListOfSignals
                                                            .last.exitPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                        color: Color.fromRGBO(
                                                            252, 252, 252, 1)),
                                                  ),
                                                Spacer(),
                                                SizedBox(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width /
                                                      18,
                                                ),
                                                Spacer(),
                                                if (tempListOfSignals
                                                    .last.gain == true)
                                                  Text(
                                                    '\$' +
                                                        tempListOfSignals
                                                            .last.exitPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                        color: Color.fromRGBO(
                                                            51, 182, 255, 1)),
                                                  )
                                                else
                                                  Text(
                                                    '\$' +
                                                        widget.signal.entryPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                        color: Color.fromRGBO(
                                                            51, 182, 255, 1)),
                                                  ),
                                                Spacer(),
                                                Text(
                                                  '\$' +
                                                      widget.signal.takeProfit
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'DMSans',
                                                      color: Color.fromRGBO(
                                                          0, 255, 41, 1)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 3.h),
                                            child: Stack(
                                              alignment:
                                              AlignmentDirectional.centerStart,
                                              children: [
                                                Container(
                                                  height: 1.h,
                                                  color: const Color.fromRGBO(
                                                      196, 196, 196, 1),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 24.w, right: 25.w),
                                                  child: Center(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 8.r,
                                                          width: 8.r,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color:
                                                              const Color.fromRGBO(
                                                                  255, 91, 91, 1)),
                                                        ),
                                                        Spacer(),
                                                        if (tempListOfSignals
                                                            .last.gain == true)
                                                          Container(
                                                            height: 8.r,
                                                            width: 8.r,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    252, 252, 252, 1)),
                                                          )
                                                        else
                                                          Container(),
                                                        Container(
                                                          height: 2.h,
                                                          padding: EdgeInsets.only(
                                                              top: 0.5.h),
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width /
                                                              28,
                                                          color: tempListOfSignals
                                                              .last.gain == true
                                                              ? const Color.fromRGBO(
                                                              0, 255, 41, 1)
                                                              : const Color.fromRGBO(
                                                              255, 91, 91, 1),
                                                          child: tempListOfSignals
                                                              .last.gain == true
                                                              ? null
                                                              : CustomPaint(
                                                              painter:
                                                              LeftArrowPainter()),
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.only(
                                                                left: 4.w,
                                                                right: 4.w,
                                                                bottom: 2.h),
                                                            decoration: BoxDecoration(
                                                                color: tempListOfSignals
                                                                    .last.gain == true
                                                                    ? const Color
                                                                    .fromRGBO(
                                                                    0, 255, 41, 1)
                                                                    : const Color
                                                                    .fromRGBO(
                                                                    255, 91, 91, 1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    16.w)),
                                                            child: tempListOfSignals
                                                                .last.gain == true
                                                                ? Text(
                                                              getPercentageChange(
                                                                  (tempListOfSignals
                                                                      .last.entryPrice)!,
                                                                  (tempListOfSignals
                                                                      .last.exitPrice)!)
                                                                  .toStringAsFixed(2) +
                                                                  '\% gain',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: textBlack,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'DMSans',
                                                              ),
                                                            )
                                                                : Text(
                                                              getPercentageChange(
                                                                  (tempListOfSignals
                                                                      .last.entryPrice)!,
                                                                  (tempListOfSignals
                                                                      .last.exitPrice)!)
                                                                  .toStringAsFixed(2) +
                                                                  '\% loss',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: textDefault,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'DMSans',
                                                              ),
                                                            )),
                                                        if (tempListOfSignals
                                                            .last.gain == true)
                                                          Container(
                                                            height: 1.h,
                                                            padding: EdgeInsets.only(
                                                                top: 0.5.h),
                                                            width:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width /
                                                                28,
                                                            color: tempListOfSignals
                                                                .last.gain == true
                                                                ? const Color.fromRGBO(
                                                                0, 255, 41, 1)
                                                                : const Color.fromRGBO(
                                                                255, 91, 91, 1),
                                                            child: tempListOfSignals
                                                                .last.gain == false
                                                                ? null
                                                                : CustomPaint(
                                                                painter:
                                                                RightArrowPainter()),
                                                          )
                                                        else
                                                          Container(
                                                            height: 2.h,
                                                            width:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width /
                                                                28,
                                                            color: tempListOfSignals
                                                                .last.gain == true
                                                                ? const Color.fromRGBO(
                                                                0, 255, 41, 1)
                                                                : const Color.fromRGBO(
                                                                255, 91, 91, 1),
                                                          ),
                                                        if (tempListOfSignals
                                                            .last.gain == false)
                                                          Container(
                                                            height: 8.r,
                                                            width: 8.r,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    252, 252, 252, 1)),
                                                          )
                                                        else
                                                          Container(),
                                                        Spacer(),
                                                        Container(
                                                          height: 8.r,
                                                          width: 8.r,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color:
                                                              const Color.fromRGBO(
                                                                  0, 255, 41, 1)),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Stop Loss',
                                                style: textStyleSignalWidget,
                                              ),
                                              Spacer(),
                                              if (tempListOfSignals
                                                  .last.gain == true)
                                                Text(
                                                  'Entry Price',
                                                  style: textStyleSignalWidget,
                                                )
                                              else
                                                Text(
                                                  'Current Price',
                                                  style: textStyleSignalWidget,
                                                ),
                                              SizedBox(
                                                width:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width /
                                                    18,
                                              ),
                                              Spacer(),
                                              if (tempListOfSignals
                                                  .last.gain == true)
                                                Text(
                                                  'Current Price',
                                                  style: textStyleSignalWidget,
                                                )
                                              else
                                                Text(
                                                  'Entry Price',
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
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                            ],
                          ) else Container(),
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
