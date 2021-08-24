import 'package:crypto_signal_app/home_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/login_page_text_forms.dart';

import '../../auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _signInPageFormKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  late String _uid;
  final List<Widget> _signInTextForms = <Widget>[
    buildLogin(),
    buildPassword(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(13.w, 16.h, 19.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: textFieldThemeData,
              child: Form(
                key: _signInPageFormKey,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _signInTextForms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _signInTextForms[index],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: double.infinity,
              height: 52.h,
              child: CupertinoButton(
                  child: Text(
                    'Login',
                    style: textButtonStyle,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    if (!_signInPageFormKey.currentState!.validate()) {
                      return;
                    } else {
                      _signInPageFormKey.currentState!.save();
                      await _authService.signInWithEmail(
                          loginList.elementAt(0), loginList.elementAt(1));
                      loginList.clear();
                      FirebaseAnalytics().logEvent(name: 'user_logged_in', parameters:null);
                      setState(() {
                      });
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
              height: 22.h,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(style: textStyleShaded, children: [
                  TextSpan(
                      text: 'Forgot password?',
                      style: textStyleWhite,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('unlucky');
                        }),
                ])),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
