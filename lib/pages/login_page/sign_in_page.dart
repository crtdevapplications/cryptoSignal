import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(textAlign: TextAlign.center, text: TextSpan(
          style: textStyleShaded,
          children: [
            TextSpan(text: 'Forgot password?', style: textStyleWhite, recognizer: TapGestureRecognizer()..onTap = (){ debugPrint('unlucky'); }), ])),
    );
  }
}

