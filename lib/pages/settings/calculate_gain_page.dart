import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';

class CalculateGainPage extends StatefulWidget {
  const CalculateGainPage({Key? key}) : super(key: key);

  @override
  _CalculateGainPageState createState() => _CalculateGainPageState();
}

class _CalculateGainPageState extends State<CalculateGainPage> {
  final TextEditingController _calculateGainTextController = TextEditingController();
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _calculateGainTextController.text = '1000';
    _dropdownValue = 'Last month';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculate Gain',
            style: textStyleHeader,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
        ),
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: SafeArea(
          child: SingleChildScrollView(
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
                              text: 'Calculate your potential gain, based on past signal performance')),
                      SizedBox(
                        height: 32.h,
                      ),
                      Container(
                        height: 42.h,
                        child: Row(
                          children: [
                            RichText(text: TextSpan(style: textButtonStyle, text: 'Initial investment')),
                            Spacer(),
                            Container(
                              width: 129.w,
                              child: TextFormField(
                                controller: _calculateGainTextController,
                                maxLength: 10,

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
                            RichText(text: TextSpan(style: textButtonStyle, text: 'Time period')),
                            Spacer(),
                            Container(
                                width: 129.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color:toggleButtonBorderColor,
                                    border: Border.all(color: toggleButtonBorderColor),
                                  borderRadius: BorderRadius.circular(4.w)
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w, right: 8.w),
                                    child: Theme(
                                      data: appThemeData,
                                      child: DropdownButton<String>(
                                        value: _dropdownValue,
                                        isExpanded:true,
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
                                          setState(() {
                                            _dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Last week',
                                          'Last month',
                                          'Last year',
                                        ].map<DropdownMenuItem<String>>((String value) {
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
                      SizedBox(
                        height: 32.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 52.h,
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        child: Center(
                          child: Row(
                            children: [
                              RichText(text: TextSpan(style: textButtonStyle, text: 'Your profit')),
                              Spacer(),
                              Text(
                                _calculateGainTextController.text,
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
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        child: Center(
                          child: Row(
                            children: [
                              RichText(text: TextSpan(style: textButtonStyle, text: 'Your total new balance')),
                              Spacer(),
                              Text(
                                _calculateGainTextController.text,
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
                      Container(
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                        child: Center(
                            child: Text(
                          '39.27%',
                          style: textGainGreen,
                        )),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      brokerAd(true),
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
                                        builder: (context) => const TermsAndConditionsPage(),
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
                                        builder: (context) => const PrivacyPolicyPage(),
                                      ),
                                    );
                                  }),
                          ])),
                    ],
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
