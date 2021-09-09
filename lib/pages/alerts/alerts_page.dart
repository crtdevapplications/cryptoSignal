import 'package:crypto_signal_app/alert_service.dart';
import 'package:crypto_signal_app/pages/alerts/alert_edit_page.dart';
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
import '../../user.dart';
import 'add_to_alerts_page.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late bool temporalBool;
  late bool anotherBool;
  bool _activeAlertSwitchValue = true;

  @override
  void initState() {
    temporalBool = false;
    anotherBool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 38.h,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 11.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Active', style: textStyleHeader),
                    Spacer(),
                    if (temporalBool == false)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CupertinoButton(
                            child: Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                'assets/plus.svg',
                                color: Colors.white,
                                height: 24.r,
                                width: 24.r,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) => const AddToAlertsPage(),
                                ),
                              );
                              setState(() {
                              });
                            },
                            padding: EdgeInsets.zero,
                          ),
                          CupertinoButton(
                            child: Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                'assets/edit.svg',
                                color: Colors.white,
                                height: 24.r,
                                width: 24.r,
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (context) => const AlertEditPage(),
                              //   ),
                              // );
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            if (Hive.box<AppUser>('appuser')
                .values
                .first
                .listOfAlertCryptos
                .where((element) => element.active == true)
                .isEmpty)
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 15.w,
                ),
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const AddToAlertsPage(),
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
                            'New alert',
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
                ),
              )
            else if (Hive.box<AppUser>('appuser')
                .values
                .first
                .listOfAlertCryptos
                .where((element) => element.active == true)
                .isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Hive.box<AppUser>('appuser')
                      .values
                      .first
                      .listOfAlertCryptos
                      .where((element) => element.active == true)
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 100.h,
                          padding: EdgeInsets.all(16.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(34, 36, 51, 0.8),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/cryptoicons/' +
                                    Hive.box<AppUser>('appuser')
                                        .values
                                        .first
                                        .listOfAlertCryptos
                                        .where(
                                            (element) => element.active == true)
                                        .elementAt(index)
                                        .symbol
                                        .toLowerCase() +
                                    '.svg',
                                width: 48.r,
                                height: 48.r,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Hive.box<AppUser>('appuser')
                                            .values
                                            .first
                                            .listOfAlertCryptos
                                            .where((element) =>
                                                element.active == true)
                                            .elementAt(index)
                                            .symbol
                                            .toUpperCase() +
                                        '/USD',
                                    style: textStyleMiniHeader,
                                  ),
                                  Text(
                                    '> \$' +
                                        Hive.box<AppUser>('appuser')
                                            .values
                                            .first
                                            .listOfAlertCryptos
                                            .where((element) =>
                                                element.active == true)
                                            .elementAt(index)
                                            .abovePrice
                                            .toString(),
                                    style: textButtonStyle,
                                  ),
                                  Text(
                                      '< \$' +
                                          Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfAlertCryptos
                                              .where((element) =>
                                                  element.active == true)
                                              .elementAt(index)
                                              .belowPrice
                                              .toString(),
                                      style: textButtonStyle),
                                ],
                              ),
                              Spacer(),
                              Switch(
                                splashRadius: 0,
                                activeTrackColor: Colors.white,
                                thumbColor: Hive.box<AppUser>('appuser')
                                            .values
                                            .first
                                            .listOfAlertCryptos
                                            .where((element) =>
                                                element.active == true)
                                            .elementAt(index)
                                            .active ==
                                        false
                                    ? MaterialStateProperty.all(
                                        Color.fromRGBO(196, 196, 196, 1))
                                    : MaterialStateProperty.all(
                                        Color.fromRGBO(84, 122, 255, 1)),
                                inactiveTrackColor:
                                    Color.fromRGBO(196, 196, 196, 1),
                                value: Hive.box<AppUser>('appuser')
                                    .values
                                    .first
                                    .listOfAlertCryptos
                                    .where((element) => element.active == true)
                                    .elementAt(index)
                                    .active,
                                onChanged: (bool value) {
                                  updateAlertCrypto(Alert(
                                      symbol: Hive.box<AppUser>('appuser')
                                          .values
                                          .first
                                          .listOfAlertCryptos
                                          .where((element) => element.active == true)
                                          .elementAt(index).symbol,
                                      active: value,
                                      abovePrice: Hive.box<AppUser>('appuser')
                                          .values
                                          .first
                                          .listOfAlertCryptos
                                          .where((element) => element.active == true)
                                          .elementAt(index).abovePrice,
                                      belowPrice: Hive.box<AppUser>('appuser')
                                          .values
                                          .first
                                          .listOfAlertCryptos
                                          .where((element) => element.active == true)
                                          .elementAt(index).belowPrice,
                                      repeatAlert: Hive.box<AppUser>('appuser')
                                          .values
                                          .first
                                          .listOfAlertCryptos
                                          .where((element) => element.active == true)
                                          .elementAt(index).repeatAlert));
                                  deleteAlertCrypto(Hive.box<AppUser>('appuser').values.first.listOfAlertCryptos.where((element) => element.active == true).elementAt(index));
                                  setState(() {
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        )
                      ],
                    );
                  },
                ),
              ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 15.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Past',
                    style: textStyleHeader,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  if (Hive.box<AppUser>('appuser')
                      .values
                      .first
                      .listOfAlertCryptos
                      .where((element) => element.active == false)
                      .isEmpty)
                    Text(
                      'You dont have past alert',
                      style: textStyleWhite,
                    )
                  else if (Hive.box<AppUser>('appuser')
                      .values
                      .first
                      .listOfAlertCryptos
                      .where((element) => element.active == false)
                      .isNotEmpty)
                    ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Hive.box<AppUser>('appuser')
                          .values
                          .first
                          .listOfAlertCryptos
                          .where((element) => element.active == false)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: 100.h,
                              padding: EdgeInsets.all(16.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 36, 51, 0.8),
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/cryptoicons/' +
                                        Hive.box<AppUser>('appuser')
                                            .values
                                            .first
                                            .listOfAlertCryptos
                                            .where((element) =>
                                                element.active == false)
                                            .elementAt(index)
                                            .symbol
                                            .toLowerCase() +
                                        '.svg',
                                    width: 48.r,
                                    height: 48.r,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Hive.box<AppUser>('appuser')
                                                .values
                                                .first
                                                .listOfAlertCryptos
                                                .where((element) =>
                                                    element.active == false)
                                                .elementAt(index)
                                                .symbol
                                                .toUpperCase() +
                                            '/USD',
                                        style: textStyleMiniHeader,
                                      ),
                                      Text(
                                        '> \$' +
                                            Hive.box<AppUser>('appuser')
                                                .values
                                                .first
                                                .listOfAlertCryptos
                                                .where((element) =>
                                                    element.active == false)
                                                .elementAt(index)
                                                .abovePrice
                                                .toString(),
                                        style: textButtonStyle,
                                      ),
                                      Text(
                                          '< \$' +
                                              Hive.box<AppUser>('appuser')
                                                  .values
                                                  .first
                                                  .listOfAlertCryptos
                                                  .where((element) =>
                                                      element.active == false)
                                                  .elementAt(index)
                                                  .belowPrice
                                                  .toString(),
                                          style: textButtonStyle),
                                    ],
                                  ),
                                  Spacer(),
                                  Switch(
                                    splashRadius: 0,
                                    activeTrackColor: Colors.white,
                                    thumbColor: Hive.box<AppUser>('appuser')
                                                .values
                                                .first
                                                .listOfAlertCryptos
                                                .where((element) =>
                                                    element.active == false)
                                                .elementAt(index)
                                                .active ==
                                            false
                                        ? MaterialStateProperty.all(
                                            Color.fromRGBO(196, 196, 196, 1))
                                        : MaterialStateProperty.all(
                                            Color.fromRGBO(84, 122, 255, 1)),
                                    inactiveTrackColor:
                                        Color.fromRGBO(196, 196, 196, 1),
                                    value: Hive.box<AppUser>('appuser')
                                        .values
                                        .first
                                        .listOfAlertCryptos
                                        .where((element) =>
                                            element.active == false)
                                        .elementAt(index)
                                        .active,
                                    onChanged: (bool value) {
                                      updateAlertCrypto(Alert(
                                          symbol: Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfAlertCryptos
                                              .where((element) => element.active == false)
                                              .elementAt(index).symbol,
                                          active: value,
                                          abovePrice: Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfAlertCryptos
                                              .where((element) => element.active == false)
                                              .elementAt(index).abovePrice,
                                          belowPrice: Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfAlertCryptos
                                              .where((element) => element.active == false)
                                              .elementAt(index).belowPrice,
                                          repeatAlert: Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfAlertCryptos
                                              .where((element) => element.active == false)
                                              .elementAt(index).repeatAlert));
                                      deleteAlertCrypto(Hive.box<AppUser>('appuser').values.first.listOfAlertCryptos.where((element) => element.active == false).elementAt(index));
                                      setState(() {
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            )
                          ],
                        );
                      },
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
