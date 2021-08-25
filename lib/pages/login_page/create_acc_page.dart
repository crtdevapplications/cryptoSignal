import 'package:crypto_signal_app/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/login_page/login_page_text_forms.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phone_number/phone_number.dart';
import '../../auth_service.dart';
import '../../user.dart';
import 'package:http/http.dart' as http;

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({Key? key}) : super(key: key);

  @override
  _CreateAccPageState createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage>
    with AutomaticKeepAliveClientMixin {
  final AuthService _authService = AuthService();
  late String _password;
  late String _uid;
  late String _leadIP;
  late final Future<String?> ipResponseFuture;
  final GlobalKey<FormState> _createAccPageFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
  final List<Widget> _createAccPageTextForms = <Widget>[
    buildFirstName(),
    buildLastName(),
    buildEmail(),
    buildPhoneNumber(),
  ];
  bool isChecked = false;

  @override
  void initState() {
    _password = _authService.generatePassword();
    ipResponseFuture = _authService.getIP();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                          checkColor: textShaded,
                          fillColor: isChecked == false
                              ? MaterialStateProperty.all(
                                  const Color.fromRGBO(167, 43, 47, 1))
                              : MaterialStateProperty.all(checkboxColor),
                          splashRadius: 0,
                          value: isChecked,
                          activeColor: toggleButtonBorderColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w)),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  'I agree to receive a call from broker partner',
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
                        onPressed: () async {
                          if (isChecked == true) {
                            if (!_createAccPageFormKey.currentState!
                                .validate()) {
                              return;
                            } else {
                              _createAccPageFormKey.currentState!.save();
                              _leadIP = (await ipResponseFuture)!;
                              await _authService
                                  .registerWithEmail(
                                      signUpList.elementAt(2), _password)
                                  .then((value) => _uid = value);
                              AppUser user = AppUser(
                                  firstName: signUpList.elementAt(0),
                                  lastName: signUpList.elementAt(1),
                                  email: signUpList.elementAt(2),
                                  phoneNumber: signUpList.elementAt(3),
                                  countryPhoneCode: '123',
                                  password: _password,
                                  affiliateID: '7771777',
                                  offerID: '1737',
                                  countryISO: 'DE',
                                  landDomain: 'domain.com',
                                  uid: _uid,
                                  leadIP: _leadIP,
                                  dateTime: DateTime.now());
                              addUser(user);
                              await _authService.updateUserData(user, _uid);
                              //email = ssfw@er.ru
                              //password = cc2t+5W%6T
                              FirebaseAnalytics().logEvent(
                                  name: 'new_account_created',
                                  parameters: null);
                              signUpList.clear();
                              setState(() {});
                            }
                          } else {}
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
                        const TextSpan(
                            text: 'By pressing Sign Up you agree to our\n'),
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
