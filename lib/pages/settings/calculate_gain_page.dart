import 'package:crypto_signal_app/pages/settings/calculate_gain_widget.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:hive/hive.dart';

import '../../user.dart';

class CalculateGainPage extends StatefulWidget {
  const CalculateGainPage({Key? key}) : super(key: key);

  @override
  _CalculateGainPageState createState() => _CalculateGainPageState();
}

class _CalculateGainPageState extends State<CalculateGainPage> {
  final TextEditingController _calculateGainTextController =
      TextEditingController();
  late String _dropdownValue;
  late String _currentUserInvestment;
  late DateTime selectedDate;
  double unrealizedGains = 0;
  DateTime lastMonth = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime lastThreeMonths = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  DateTime lastSixMonths = DateTime(
      DateTime.now().year, DateTime.now().month - 6, DateTime.now().day);
  double totalGainFromClosedSignals = 0;

  @override
  void initState() {
    super.initState();
    if(listOfOpenSignals.isNotEmpty){
    unrealizedGains = listOfOpenSignals
        .map((e) => e.percentChange)
        .toList()
        .reduce(
            (value, element) => value! + element!)!;}
    _calculateGainTextController.text = '1000';
    _currentUserInvestment = _calculateGainTextController.text;
    _dropdownValue = 'Last month';
    if (_dropdownValue == 'Last month') {
      selectedDate = lastMonth;
    } else if (_dropdownValue == '3 months') {
      selectedDate = lastThreeMonths;
    } else {
      selectedDate = lastSixMonths;
    }
    var listOfSignalsInChoosedTime = listOfClosedSignals
        .where((element) => element.dateAdded!.isAfter(selectedDate));
    if (listOfSignalsInChoosedTime.isNotEmpty) {
      totalGainFromClosedSignals = listOfSignalsInChoosedTime.map((e) => e.percentChange)
          .toList()
          .reduce((value, element) => value! + element!)!;
    }
  }
  void calculateGainLogic(){
    _currentUserInvestment = _calculateGainTextController.text;
    if (_dropdownValue == 'Last month') {
      selectedDate = lastMonth;
    } else if (_dropdownValue == '3 months') {
      selectedDate = lastThreeMonths;
    } else {
      selectedDate = lastSixMonths;
    }
    var listOfSignalsInChoosedTime = listOfClosedSignals
        .where((element) => element.dateAdded!.isAfter(selectedDate));
    if (listOfSignalsInChoosedTime.isNotEmpty) {
      totalGainFromClosedSignals = listOfSignalsInChoosedTime.map((e) => e.percentChange)
          .toList()
          .reduce((value, element) => value! + element!)!;
    }
    else{
      totalGainFromClosedSignals = 0;
    }
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
          appBar: AppBar(
            title: Text(
              'Calculate Gain',
              style: textStyleHeader,
            ),
            elevation: 0,
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
          ),
          backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Theme(
                    data: textFieldThemeData,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: richTextRegular,
                                text:
                                    'Calculate your potential gain, based on past signal performance')),
                        SizedBox(
                          height: 32.h,
                        ),
                        Container(
                          height: 42.h,
                          child: Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: textButtonStyle,
                                      text: 'Initial investment')),
                              Spacer(),
                              Container(
                                width: 129.w,
                                child: TextFormField(
                                  onChanged: (value){},
                                  onTap: (){},
                                  controller: _calculateGainTextController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          height: 42.h,
                          child: Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: textButtonStyle,
                                      text: 'Time period')),
                              Spacer(),
                              Container(
                                  width: 129.w,
                                  height: 42.h,
                                  decoration: BoxDecoration(
                                      color: toggleButtonBorderColor,
                                      border: Border.all(
                                          color: toggleButtonBorderColor),
                                      borderRadius: BorderRadius.circular(4.w)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 8.w),
                                      child: Theme(
                                        data: appThemeData,
                                        child: DropdownButton<String>(
                                          value: _dropdownValue,
                                          isExpanded: true,
                                          icon: SvgPicture.asset(
                                            'assets/arrowdown.svg',
                                            height: 24.r,
                                            width: 24.r,
                                          ),
                                          iconSize: 24,
                                          dropdownColor: checkboxColor,
                                          isDense: true,
                                          elevation: 0,
                                          style: textButtonStyle,
                                          underline: Container(
                                            height: 0,
                                          ),
                                          onChanged: (String? newValue) {
                                            _dropdownValue = newValue!;
                                            setState(() {
                                            });
                                          },
                                          items: <String>[
                                            'Last month',
                                            '3 months',
                                            '6 months',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          height: 52.h,
                          child: CupertinoButton(
                              child: Text(
                                'Calculate',
                                style: textButtonStyle,
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                calculateGainLogic();
                                setState(() {});
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
                        SizedBox(
                          height: 32.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 52.h,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Center(
                            child: Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: textButtonStyle,
                                        text: 'Your profit')),
                                Spacer(),
                                Text(
                                  '\$' +
                                      ((totalGainFromClosedSignals / 100) *

                                              double.parse(
                                                  _currentUserInvestment))
                                          .toStringAsFixed(2) +
                                      '(' +
                                      totalGainFromClosedSignals
                                          .toStringAsFixed(2) +
                                      '\%)',
                                  style: textGainGreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 11.h),
                        Container(
                          width: double.infinity,
                          height: 52.h,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Center(
                            child: Row(
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: textButtonStyle,
                                        text: 'Your total new balance')),
                                Spacer(),
                                Text(
                                    totalGainFromClosedSignals == 0 ? _currentUserInvestment :
                                  '\$' +
                                      ((totalGainFromClosedSignals / 100) *
                                                  double.parse(
                                                      _currentUserInvestment) +
                                              double.parse(
                                                  _currentUserInvestment))
                                          .toStringAsFixed(2),
                                  style: textGainGreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        RichText(
                            text: TextSpan(
                                style: richTextRegular,
                                text:
                                    'Unrealized gains for signals that are still open. Have not reached their profit or loss targets')),
                        SizedBox(height: 12.h),
                        CalculateGainWidget(),
                        // Container(
                        //   width: double.infinity,
                        //   height: 52.h,
                        //   decoration: BoxDecoration(
                        //       color: cardBackground,
                        //       borderRadius: BorderRadius.circular(16.r)),
                        //   child: Center(
                        //       child: Text(
                        //         unrealizedGains.toStringAsFixed(3) +
                        //         '\%',
                        //     style: textGainGreen,
                        //   )),
                        // ),
                        SizedBox(
                          height: 32.h,
                        ),
                        brokerAd(true, Hive.box<AppUser>('appuser').values.first.brokerAdURL),
                        SizedBox(
                          height: 32.h,
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(style: textStyleShaded, children: [
                              const TextSpan(
                                  text:
                                      'Risk Warning: Please remember that past performance may not be indicative of future results. By using the app you agree to our\n\nBy using the app you agree to our\n'),
                              TextSpan(
                                  text: 'Terms and Conditions',
                                  style: textStyleWhite,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              const TermsAndConditionsPage(),
                                        ),
                                      );
                                    }),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: textStyleWhite,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              const PrivacyPolicyPage(),
                                        ),
                                      );
                                    }),
                            ])),
                        SizedBox(height: 12.h,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
