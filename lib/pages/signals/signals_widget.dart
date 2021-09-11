import 'package:crypto_signal_app/pages/signals/signal_details_page.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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

import '../../crypto_api.dart';

class SignalsWidget extends StatefulWidget {
  Signal signal;
  String status;
  bool clickable;

  SignalsWidget(this.signal, this.status, this.clickable, {Key? key})
      : super(key: key);

  @override
  _SignalsWidgetState createState() => _SignalsWidgetState();
}

class _SignalsWidgetState extends State<SignalsWidget> {
  late Future<List<CryptoApi>> _list;

  @override
  void initState() {
    _list = getASingleCrypto(widget.signal.name!.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_list]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Network error.',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFProDisplay',
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    CupertinoButton.filled(
                      onPressed: () {},
                      child: Text(
                        'Try again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Container(
              alignment: AlignmentDirectional.center,
              child: Container(
                height: 120.r,
                width: 120.r,
                child: CircularProgressIndicator(
                  strokeWidth: 7.w,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            List<CryptoApi> listOfSignalsDataFromApi =
                (snapshot.data as List)[0] as List<CryptoApi>;
            return AbsorbPointer(
              absorbing: !widget.clickable,
              child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          SignalDetails(widget.signal, widget.status),
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                child: Container(
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
                                        widget.signal.symbol
                                                .toString()
                                                .toUpperCase() +
                                            '/USD',
                                        style: textStyleSignalDefault,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      if (listOfSignalsDataFromApi.first.gain == true)
                                        Text(
                                          getPercentageChange(
                                                      (widget
                                                          .signal.entryPrice)!,
                                                      listOfSignalsDataFromApi
                                                          .first.currentPrice)
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: textStyleSignalGreen,
                                        )
                                      else
                                        Text(
                                          '-' +
                                              getPercentageChange(
                                                  (widget
                                                      .signal.entryPrice)!,
                                                  listOfSignalsDataFromApi
                                                      .first.currentPrice)
                                                  .toStringAsFixed(2) +

                                              '%',
                                          style: textStyleSignalRed,
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
                                              style: textStyleSignalDefault,
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
                                              style: textStyleSignalDefault,
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
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$' + widget.signal.stopLoss.toString(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DMSans',
                                        color: Color.fromRGBO(255, 91, 91, 1)),
                                  ),
                                  Spacer(),
                                  if (listOfSignalsDataFromApi.first.gain == true)
                                    Text(
                                      '\$' +
                                          widget.signal.entryPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'DMSans',
                                          color:
                                              Color.fromRGBO(252, 252, 252, 1)),
                                    )
                                  else
                                    Text(
                                      '\$' +
                                          listOfSignalsDataFromApi
                                              .first.currentPrice
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'DMSans',
                                          color:
                                              Color.fromRGBO(252, 252, 252, 1)),
                                    ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 8.5,
                                  ),
                                  if (listOfSignalsDataFromApi.first.gain == true)
                                    Text(
                                      '\$' +
                                          listOfSignalsDataFromApi
                                              .first.currentPrice
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'DMSans',
                                          color:
                                              Color.fromRGBO(51, 182, 255, 1)),
                                    )
                                  else
                                    Text(
                                      '\$' +
                                          widget.signal.entryPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'DMSans',
                                          color:
                                              Color.fromRGBO(51, 182, 255, 1)),
                                    ),
                                  Spacer(),
                                  Text(
                                    '\$' + widget.signal.takeProfit.toString(),
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
                                    color:
                                        const Color.fromRGBO(196, 196, 196, 1),
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
                                                color: const Color.fromRGBO(
                                                    255, 91, 91, 1)),
                                          ),
                                          Spacer(),
                                          if (listOfSignalsDataFromApi.first.gain == true)
                                            Container(
                                              height: 8.r,
                                              width: 8.r,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color.fromRGBO(
                                                      252, 252, 252, 1)),
                                            )
                                          else
                                            Container(),
                                          Container(
                                            height: 1.h,
                                            padding:
                                                EdgeInsets.only(top: 0.5.h),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                24,
                                            color: listOfSignalsDataFromApi.first.gain == true
                                                ? const Color.fromRGBO(
                                                    0, 255, 41, 1)
                                                : const Color.fromRGBO(
                                                    255, 91, 91, 1),
                                            child: listOfSignalsDataFromApi.first.gain == true
                                                ? null
                                                : CustomPaint(
                                                    painter:
                                                        LeftArrowPainter()),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w),
                                              decoration: BoxDecoration(
                                                  color: listOfSignalsDataFromApi.first.gain == true
                                                      ? const Color.fromRGBO(
                                                          0, 255, 41, 1)
                                                      : const Color.fromRGBO(
                                                          255, 91, 91, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.w)),
                                              child: listOfSignalsDataFromApi.first.gain == true
                                                  ? Text(
                                                      getPercentageChange(
                                                                  (widget.signal
                                                                      .entryPrice)!,
                                                                  listOfSignalsDataFromApi
                                                                      .first
                                                                      .currentPrice)
                                                              .toStringAsFixed(
                                                                  2) +
                                                          '\% gain',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: const Color
                                                                .fromRGBO(
                                                            73, 75, 87, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                      ),
                                                    )
                                                  : Text(
                                                      '-' +
                                                          getPercentageChange(
                                                              (widget.signal
                                                                  .entryPrice)!,
                                                              listOfSignalsDataFromApi
                                                                  .first
                                                                  .currentPrice)
                                                              .toStringAsFixed(
                                                              2) +
                                                          '\% loss',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: const Color
                                                                .fromRGBO(
                                                            73, 75, 87, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'DMSans',
                                                      ),
                                                    )),
                                          if (listOfSignalsDataFromApi.first.gain == true)
                                            Container(
                                              height: 1.h,
                                              padding:
                                                  EdgeInsets.only(top: 0.5.h),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  24,
                                              color: listOfSignalsDataFromApi.first.gain == true
                                                  ? const Color.fromRGBO(
                                                      0, 255, 41, 1)
                                                  : const Color.fromRGBO(
                                                      255, 91, 91, 1),
                                              child: listOfSignalsDataFromApi.first.gain == false
                                                  ? null
                                                  : CustomPaint(
                                                      painter:
                                                          RightArrowPainter()),
                                            )
                                          else
                                            Container(
                                              height: 1.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  24,
                                              color: listOfSignalsDataFromApi.first.gain == true
                                                  ? const Color.fromRGBO(
                                                      0, 255, 41, 1)
                                                  : const Color.fromRGBO(
                                                      255, 91, 91, 1),
                                            ),
                                          if (listOfSignalsDataFromApi.first.gain == false)
                                            Container(
                                              height: 8.r,
                                              width: 8.r,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: const Color.fromRGBO(
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
                                                color: const Color.fromRGBO(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stop Loss',
                                  style: textStyleSignalWidget,
                                ),
                                Spacer(),
                                if (listOfSignalsDataFromApi.first.gain == true)
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
                                  width: MediaQuery.of(context).size.width / 16,
                                ),
                                if (listOfSignalsDataFromApi.first.gain == true)
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
              ),
            );
          }
        });
  }
}

class RightArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Color.fromRGBO(0, 255, 41, 1);
    path.moveTo(0, 0);
    path.lineTo((size.width) + 8, 0);
    path.moveTo((size.width) + 8, 0);
    path.lineTo((size.width) + 8 - 8, -6);
    path.moveTo((size.width) + 8, 0);
    path.lineTo((size.width) + 8 - 8, 6);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LeftArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Color.fromRGBO(255, 91, 91, 1);
    path.moveTo(0, 0);
    path.lineTo(-((size.width) - 8), 0);
    path.moveTo(-((size.width) - 8), 0);
    path.lineTo(-((size.width) - 8) + 8, 6);
    path.moveTo(-((size.width) - 8), 0);
    path.lineTo(-((size.width) - 8) + 8, -6);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

double getPercentageChange(double entryNumber, double currentNumber) {
  return (currentNumber - entryNumber) / entryNumber * 100;
}
