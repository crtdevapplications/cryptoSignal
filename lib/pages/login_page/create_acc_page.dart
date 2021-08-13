import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/login_page/login_page_text_forms.dart';

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({Key? key}) : super(key: key);

  @override
  _CreateAccPageState createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _createAccPageFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _snackBarKey = GlobalKey<ScaffoldMessengerState>();
  final List<Widget> _createAccPageTextForms = <Widget>[
    buildFirstName(),
    buildLastName(),
    buildEmail(),
    buildPhoneNumber(),
  ];
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(13.w, 16.h, 19.w, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: Text(
                          'Create a free account',
                          style: textStyleHeader,
                        ),
                      )),
                  SizedBox(height: 12.h),
                  Theme(
                    data: textFieldThemeData,
                    child: Form(
                      key: _createAccPageFormKey,
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _createAccPageTextForms.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _createAccPageTextForms[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 3.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          checkColor: textShaded,
                          fillColor: MaterialStateProperty.all(checkboxColor),
                          splashRadius: 0,
                          value: isChecked,
                          activeColor: toggleButtonBorderColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'I agree to receive a call from broker partner',
                              style: textShadedStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    if (isChecked == true)
                                      isChecked = false;
                                    else
                                      isChecked = true;
                                  });
                                }),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(13.w, 0, 19.w, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 52.h,
                    child: CupertinoButton(
                        child: Text(
                          'Sign Up',
                          style: textButtonStyle,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (isChecked == true) {
                            if (!_createAccPageFormKey.currentState!.validate()) {
                              return;
                            }
                          } else {
                            _snackBarKey.currentState?.showSnackBar(const SnackBar(content: Text('You must agree')));
                          }
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
                    height: 34.h,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(style: textStyleShaded, children: [
                        const TextSpan(text: 'By pressing Sign Up you agree to our\n'),
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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
