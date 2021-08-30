import 'package:crypto_signal_app/pages/alerts/alert_crypto_widget.dart';
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

class AlertEditPage extends StatefulWidget {
  const AlertEditPage({Key? key}) : super(key: key);

  @override
  _AlertEditPageState createState() => _AlertEditPageState();
}

class _AlertEditPageState extends State<AlertEditPage> {
  late bool _isAboveChecked;
  late bool _isBelowChecked;
  late bool _repeatAlertSwitchValue;
  TextEditingController _aboveAlertController = TextEditingController();
  TextEditingController _belowAlertController = TextEditingController();
  TextEditingController _abovePercentChangeController = TextEditingController();
  TextEditingController _belowPercentChangeController = TextEditingController();

  @override
  void initState() {
    _isAboveChecked = true;
    _isBelowChecked = true;
    _repeatAlertSwitchValue = true;
    _aboveAlertController.text = '1200';
    _belowAlertController.text = '1000';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
          appBar: AppBar(
            title: Text(
              'New alert',
              style: textStyleHeader,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
          ),
          body: SafeArea(
            child: Theme(
              data: textFieldThemeData,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 16.w,
                    //   ),
                    //   child: AlertCryptoWidget(
                    //     'btc',
                    //     true,
                    //     32210.93,
                    //     0.085000,
                    //   ),
                    // ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, right: 6.w, bottom: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: SizedBox(
                                  height: 24.r,
                                  width: 24.r,
                                  child: Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(buttonGradientStart),
                                      splashRadius: 0,
                                      value: _isAboveChecked,
                                      activeColor: toggleButtonBorderColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isAboveChecked = value!;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Above',
                                style: textButtonStyle,
                              ),
                              Spacer(),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_minus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                              Container(
                                height: 42.h,
                                width: 129.w,
                                child: TextFormField(
                                  enabled: _isAboveChecked,
                                  controller: _aboveAlertController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_plus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, right: 6.w, bottom: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Percent change',
                                style: textButtonStyle,
                              ),
                              Spacer(),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_minus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                              Container(
                                height: 42.h,
                                width: 129.w,
                                child: TextFormField(
                                  enabled: _isAboveChecked,
                                  controller: _abovePercentChangeController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_plus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, right: 6.w, bottom: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: SizedBox(
                                  height: 24.r,
                                  width: 24.r,
                                  child: Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(buttonGradientStart),
                                      splashRadius: 0,
                                      value: _isBelowChecked,
                                      activeColor: toggleButtonBorderColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isBelowChecked = value!;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Below',
                                style: textButtonStyle,
                              ),
                              Spacer(),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_minus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                              Container(
                                height: 42.h,
                                width: 129.w,
                                child: TextFormField(
                                  enabled: _isBelowChecked,
                                  controller: _belowAlertController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_plus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w, right: 6.w, bottom: 12.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Percent change',
                                style: textButtonStyle,
                              ),
                              Spacer(),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_minus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                              Container(
                                height: 42.h,
                                width: 129.w,
                                child: TextFormField(
                                  enabled: _isBelowChecked,
                                  controller: _belowPercentChangeController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    'assets/white_plus.svg',
                                    color: Colors.white,
                                    height: 24.r,
                                    width: 24.r,
                                  ),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,),
                      child: Container(
                        height: 52.h,
                        width: double.infinity,
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        padding: EdgeInsets.fromLTRB(16.w, 0, 9.w, 0),
                        child: Center(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text(
                              'Repeat alert',
                              style: textButtonStyle,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Switch(
                              splashRadius: 0,
                              activeTrackColor: Colors.white,
                              thumbColor: _repeatAlertSwitchValue == false ?  MaterialStateProperty.all(Color.fromRGBO(196, 196, 196, 1)): MaterialStateProperty.all(Color.fromRGBO(84, 122, 255, 1)),
                              inactiveTrackColor: Color.fromRGBO(196, 196, 196, 1),
                              value: _repeatAlertSwitchValue,
                              onChanged: (bool value) {
                                setState(() {
                                  _repeatAlertSwitchValue = value;
                                });
                              },
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 26.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      child: Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 40.w, 16.h),
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: Text('Send me a push notification when the price of BTC/USD is above \$'+_aboveAlertController.text, style: textButtonStyle,)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      child: Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 40.w, 16.h),
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: Text('Send me a push notification when the price of BTC/USD is below \$'+_belowAlertController.text, style: textButtonStyle,)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 12.h),
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        child: CupertinoButton(
                            child: Text(
                              'Create alert',
                              style: textButtonStyle,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                              });
                            }),
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
        ),
      ),
    );
  }
}
