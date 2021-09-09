import 'package:crypto_signal_app/pages/signals/signal_details_page.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/pages/signals/signals_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';
import 'package:crypto_signal_app/pages/settings/calculate_gain_page.dart';
import 'package:hive/hive.dart';

import '../../user.dart';

class LongTermPage extends StatefulWidget {
  String type;
  LongTermPage(this.type, {Key? key}) : super(key: key);

  @override
  _LongTermPageState createState() => _LongTermPageState();
}

class _LongTermPageState extends State<LongTermPage> {
  late List<Signal> listOfTotalGain;
  double totalGain = 0;

  @override
  void initState() {
    listOfTotalGain =
        listOfClosedSignals.where((element) => element.type!.toLowerCase() ==
            widget.type && element.gain == true)
            .toList();
    if (listOfTotalGain.isNotEmpty) {
      totalGain = listOfTotalGain.map((e) => e.percentChange)
          .toList()
          .reduce((value, element) => value! + element!)!;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Free signal',
                    style: textStyleHeader,
                  ),
                  Spacer(),
                  CupertinoButton(
                      child: SvgPicture.asset(
                        'assets/questionmark.svg',
                        height: 24.r,
                        width: 24.r,
                        color: bottomNavBarColor,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 15.w,
              ),
              child: SignalsWidget(listOfOpenSignals
                  .where((element) =>
              element.type!.toLowerCase() == widget.type)
                  .first, 'open', true,),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    listOfFilteredOpenSignals
                        .where((element) =>
                    element.type!.toLowerCase() == widget.type)
                        .length
                        .toString() +
                        ' Open signals',
                    style: textStyleHeader,
                  ),
                  Spacer(),
                  CupertinoButton(
                      child: SvgPicture.asset(
                        'assets/questionmark.svg',
                        height: 24.r,
                        width: 24.r,
                        color: bottomNavBarColor,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 15.w,
              ),
              child: brokerAd(true, Hive.box<AppUser>('appuser').values.first.brokerAdURL),
            ),
            SizedBox(
              height: 30.h,
            ),
            // Spacer(),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    listOfFilteredClosedSignals
                        .where((element) =>
                    element.type!.toLowerCase() == widget.type)
                        .length
                        .toString() +
                        ' Closed signals',
                    style: textStyleHeader,
                  ),
                  Spacer(),
                  CupertinoButton(
                      child: SvgPicture.asset(
                        'assets/questionmark.svg',
                        height: 24.r,
                        width: 24.r,
                        color: bottomNavBarColor,
                      ),
                      onPressed: () {
                      })
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
              child: Container(
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
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
                    // if (true)
                    Text(
                      totalGain.toStringAsFixed(3) +
                          '%',
                      style: textStyleHeaderGreen,
                    )
                    // else
                    //   Text(
                    //     '-' '8.95' '%',
                    //     style: textStyleHeaderRed,
                    //   )
                  ],
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOfFilteredClosedSignals.where((element) => element.type!.toLowerCase() ==
                    widget.type).length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, bottom: 12.h),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => SignalDetails(
                                listOfFilteredClosedSignals.where((element) => element.type!.toLowerCase() ==
                                    widget.type).elementAt(index), 'closed'),
                          ),
                        );
                      },
                      child: Container(
                        height: 80.h,
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 26.w, 16.h),
                        decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(16.w)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/cryptoicons/' + listOfFilteredClosedSignals
                                  .elementAt(index)
                                  .symbol!
                                  .toLowerCase() + '.svg',
                              height: 48.r,
                              width: 48.r,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              listOfFilteredClosedSignals
                                  .elementAt(index)
                                  .symbol!
                                  .toUpperCase() + '/USD',
                              style: textButtonStyle,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/arrowright.svg',
                              height: 24.r,
                              width: 24.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
             brokerAd(false, Hive.box<AppUser>('appuser').values.first.brokerAdURL),
          ],
        ),
      ),
    );
  }
}
