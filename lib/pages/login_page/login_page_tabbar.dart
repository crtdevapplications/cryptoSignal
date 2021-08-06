import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';

class LoginPageTabBar extends StatefulWidget {
  const LoginPageTabBar({Key? key}) : super(key: key);

  @override
  _LoginPageTabBarState createState() => _LoginPageTabBarState();
}

class _LoginPageTabBarState extends State<LoginPageTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(13.w),
                child: Container(
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.white,
                      labelColor: textBlack,
                      indicator: const BoxDecoration(color: Colors.white),
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4.w),
                                  topLeft: Radius.circular(4.w),
                                ),
                                border: Border(
                                    left: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    right: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    top: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    bottom: BorderSide(color: toggleButtonBorderColor, width: 1))),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text('Sign Up'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(4.w),
                                  topRight: Radius.circular(4.w),
                                ),
                                border: Border(
                                    right: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    left: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    top: BorderSide(color: toggleButtonBorderColor, width: 1),
                                    bottom: BorderSide(color: toggleButtonBorderColor, width: 1))),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text('Login'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CreateAccPage(),
                    SignInPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
