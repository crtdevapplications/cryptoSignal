import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in.dart';
import 'package:crypto_signal_app/pages/login_page/toggle_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    super.initState();
    userIsLoggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ToggleButtonsWidget(),
              ),
              CreateAccPage(),
              SignInPage(),
            ],
          ),
    ));
  }
}
