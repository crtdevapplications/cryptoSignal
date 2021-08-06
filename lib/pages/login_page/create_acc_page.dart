import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({Key? key}) : super(key: key);

  @override
  _CreateAccPageState createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  final TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13.w, 16.h, 19.w, 0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Create a free account',
                style: textStyleHeader,
              )),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(style: textStyleShaded, children: [
                TextSpan(text: 'By pressing Sign Up you agree to our\n'),
                TextSpan(
                    text: 'Terms and Conditions',
                    style: textStyleWhite,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('testmessage');
                      }),
                const TextSpan(text: ' and '),
                TextSpan(
                    text: 'Privacy Policy',
                    style: textStyleWhite,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('messagetest');
                      }),
              ])),
          Container(
            height: 56.h,
            color: Color.fromRGBO(255, 255, 255, 0.1),
            child: CupertinoTextField(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(4.h),),
              onChanged: (String value) {},
              cursorHeight: 22.h,
              placeholder: '  First name',
              controller: inputController,
              maxLength: 7,
              prefix: Icon(Icons.flag),
              placeholderStyle: TextStyle(fontSize: 16.sp, color: const Color.fromRGBO(150, 149, 155, 1)),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
