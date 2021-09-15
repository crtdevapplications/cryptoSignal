import 'package:crypto_signal_app/broker_ad_service.dart';
import 'package:crypto_signal_app/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
import 'package:provider/provider.dart';
import '../../alert_service.dart';
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
  // bool isLoading = false;
  bool shouldBeShown = false;
  late String _password;
  late String _uid;
  late String _leadIP;
  String? _brokerApiResponse = '';
  late AuthService _authService;
  late BrokerAdService _brokerAdService;
  late final Future<String?> ipResponseFuture;
  final GlobalKey<FormState> _createAccPageFormKey = GlobalKey<FormState>();
  final List<Widget> _createAccPageTextForms = <Widget>[
    buildFirstName(),
    buildLastName(),
    buildEmail(),
    buildPhoneNumber(),
  ];
  bool isChecked = true;
  @override
  void initState() {
    _password = generatePassword(true, true, true, false, 9);
    print(_password);
    ipResponseFuture = getIP();
    _brokerAdService = BrokerAdService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authService = Provider.of<AuthService>(context);
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
                              // isChecked = value!;
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
                                  // setState(() {
                                  //   if (isChecked == true){
                                  //     isChecked = false;
                                  //     shouldBeShown = true;}
                                  //   else{
                                  //     isChecked = true;
                                  //     shouldBeShown = false;}
                                  // });
                                }),
                        ]),
                      ),
                    ],
                  ),
                  if (shouldBeShown == true)
                    Padding(
                      padding: EdgeInsets.only(left: 28.w),
                      child: Container(
                        height: 15.sp,
                        child: Text(
                          'Required',
                          style: errorStyle,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 15.sp,
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(13.w, 0, 19.w, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 19.h,
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
                          createAccPageActions(isChecked);
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

  void createAccPageActions(bool isChecked) async {
    FocusScope.of(context).unfocus();
    if (isChecked == true) {
      if (!_createAccPageFormKey.currentState!.validate()) {
        return;
      } else {
        setState(() {
          // isLoading = true;
        });
        _createAccPageFormKey.currentState!.save();
        _leadIP = (await ipResponseFuture)!;
        try {
          AppUser user = AppUser(
            firstName: signUpList.elementAt(0),
            lastName: signUpList.elementAt(1),
            email: signUpList.elementAt(2),
            phoneNumber: signUpList.elementAt(3),
            countryPhoneCode: choosedCountry.elementAt(1),
            password: _password,
            affiliateID: listOfID.values.elementAt(0).toString(),
            offerID: listOfID.values.elementAt(1).toString(),
            countryISO: choosedCountry.elementAt(0),
            landDomain: 'domain.com',
            uid: '',
            leadIP: _leadIP,
            dateTime: DateTime.now(),
            listOfWatchedCryptos: <String>[],
            brokerAdURL: '',
            listOfAlertCryptos: <Alert>[],
          );
          await _brokerAdService
              .registerNewUser(user, _authService)
              .then((value) => _brokerApiResponse = value);
          print(_brokerApiResponse);
          if (_brokerApiResponse != 'wrong') {
            await _authService
                .registerWithEmail(signUpList.elementAt(2), _password)
                .then((value) => _uid = value);
            AppUser finalUser = AppUser(
              firstName: signUpList.elementAt(0),
              lastName: signUpList.elementAt(1),
              email: signUpList.elementAt(2),
              phoneNumber: signUpList.elementAt(3),
              countryPhoneCode: choosedCountry.elementAt(1),
              password: _password,
              affiliateID: listOfID.values.elementAt(0).toString(),
              offerID: listOfID.values.elementAt(1).toString(),
              countryISO: choosedCountry.elementAt(0),
              landDomain: 'domain.com',
              uid: _uid,
              leadIP: _leadIP,
              dateTime: DateTime.now(),
              listOfWatchedCryptos: <String>[],
              brokerAdURL: _brokerApiResponse.toString(),
              listOfAlertCryptos: <Alert>[],
            );
            addUser(finalUser);
            _authService.notifyListenersIfUserIsAdded();
            await _authService.updateUserData(finalUser, _uid);
            FirebaseAnalytics()
                .logEvent(name: 'new_account_created', parameters: null);
          }
          else{
            correctCredentials = false;
            _createAccPageFormKey.currentState!.validate();
            setState(() {});
          }
        } on FirebaseAuthException catch (e) {
          print('Failed with error code: ${e.code}');
          print(e.message);
          correctCredentials = false;
          _createAccPageFormKey.currentState!.validate();
          setState(() {});
        } catch (e, s) {
          // FirebaseCrashlytics.instance.recordError(e, s);
          rethrow;
        }
        //email = lastfirst@mail.ru
        //password = zbS4VuI4x0
        signUpList.clear();
      }
    } else {
      shouldBeShown = true;
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;
}
