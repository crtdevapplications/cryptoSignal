import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/background_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:provider/provider.dart';

class LoginPageTabBar extends StatefulWidget {
  const LoginPageTabBar({Key? key}) : super(key: key);

  @override
  _LoginPageTabBarState createState() => _LoginPageTabBarState();
}

class _LoginPageTabBarState extends State<LoginPageTabBar> with TickerProviderStateMixin  {
  late TabController _tabController;
  @override
  void initState() {

    _tabController = TabController(vsync: this, length: 2, initialIndex: 0,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Background_Widget(
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: GestureDetector(
              onTap: () {FocusScope.of(context).unfocus();},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Container(
                      decoration:  BoxDecoration(
                          borderRadius:  BorderRadius.circular(4.w),
                          border: Border.all(color: toggleButtonBorderColor, width: 1)),
                      height: 42.h,
                      child: TabBar(
                        controller: _tabController,
                        onTap: (index){
                          setState(() {
                          });
                        },
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.white,
                        labelStyle: toggleButtonStyle,
                        labelColor: textBlack,
                        indicator: _tabController.index == 0 ? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.w),
                          topLeft: Radius.circular(4.w),
                        ),) : BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4.w),
                          topRight: Radius.circular(4.w),
                        ),),
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Sign Up', style: toggleButtonStyle,),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child:  Align(
                                alignment: Alignment.center,
                                child: Text('Login', style: toggleButtonStyle),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Expanded(
                    child:  TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
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
        ),
      ),
    );
  }
}
