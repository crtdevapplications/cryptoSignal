import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/login_page_tabbar.dart';
import 'package:provider/provider.dart';

import '../../auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);
    return Consumer <AuthService>(builder: (_, auth, __) {
      return Stack(
        children: [
          LoginPageTabBar(),
          if (_authService.isLoading == true)
            Container(
                decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.6)),
                child: Center(child: SizedBox(
                  height: 120.r,
                  width: 120.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 7.w,
                    color: Colors.white,
                  ),
                )))
        ],
      );
    });
  }
}
