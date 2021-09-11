import 'package:crypto_signal_app/home_page.dart';
import 'package:crypto_signal_app/main.dart';
import 'package:crypto_signal_app/pages/login_page/login_page.dart';
import 'package:crypto_signal_app/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/login_page/sign_in_page.dart';
import 'package:crypto_signal_app/pages/login_page/create_acc_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  late TabController _tabControllerOnboarding;

  @override
  void initState() {
    _tabControllerOnboarding = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );
    _tabControllerOnboarding.addListener(_switchTabIndex);
    super.initState();
  }

  void _switchTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: SafeArea(
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromRGBO(26, 27, 39, 1), Color.fromRGBO(26, 27, 39, 0)],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabControllerOnboarding,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Signal list',
                                          style: textStyleSuperHeader,
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          child: Text(
                                            'Skip',
                                            style: textStyleShaded,
                                          ),
                                          onPressed: () {
                                            addPreference(UserPreference(
                                                sawOnboarding: true));
                                            if (Hive.box<UserPreference>(
                                                    'userpreference')
                                                .values
                                                .isNotEmpty) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (context) => MyApp(),
                                                ),
                                              );
                                            }
                                          },
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    'See all crypto signals in one place',
                                    style: textStyleSuperWhite,
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 21.w),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/onboarding/onboarding1.png')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Watchlist',
                                          style: textStyleSuperHeader,
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          child: Text(
                                            'Skip',
                                            style: textStyleShaded,
                                          ),
                                          onPressed: () {
                                            addPreference(UserPreference(
                                                sawOnboarding: true));
                                            if (Hive.box<UserPreference>(
                                                    'userpreference')
                                                .values
                                                .isNotEmpty) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (context) => MyApp(),
                                                ),
                                              );
                                            }
                                          },
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    'Create a watchlist by trapping on the plus icon',
                                    style: textStyleSuperWhite,
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  Center(
                                      child: Image.asset(
                                          'assets/onboarding/onboarding2.png')),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Crypto signals',
                                          style: textStyleSuperHeader,
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          child: Text(
                                            'Skip',
                                            style: textStyleShaded,
                                          ),
                                          onPressed: () {
                                            addPreference(UserPreference(
                                                sawOnboarding: true));
                                            if (Hive.box<UserPreference>(
                                                    'userpreference')
                                                .values
                                                .isNotEmpty) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (context) => MyApp(),
                                                ),
                                              );
                                            }
                                          },
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    'See details about all our crypto signals including gain, take profit, and stop loss',
                                    style: textStyleSuperWhite,
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  Center(
                                      child: Image.asset(
                                          'assets/onboarding/onboarding3.png')),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Price alerts',
                                          style: textStyleSuperHeader,
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          child: Text(
                                            'Skip',
                                            style: textStyleShaded,
                                          ),
                                          onPressed: () {
                                            addPreference(UserPreference(
                                                sawOnboarding: true));
                                            if (Hive.box<UserPreference>(
                                                    'userpreference')
                                                .values
                                                .isNotEmpty) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (context) => MyApp(),
                                                ),
                                              );
                                            }
                                          },
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    'See custom alerts for crypto',
                                    style: textStyleSuperWhite,
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                  Center(
                                      child: Image.asset(
                                          'assets/onboarding/onboarding4.png')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: Container(
                    width: 72.w,
                    height: 12.h,
                    child: TabBar(
                      controller: _tabControllerOnboarding,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: toggleButtonStyle,
                      indicatorWeight: 0,
                      labelPadding: EdgeInsets.zero,
                      labelColor: textBlack,
                      indicator: const BoxDecoration(
                          color: Color.fromRGBO(196, 196, 196, 1),
                          shape: BoxShape.circle),
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(196, 196, 196, 0.2)),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(196, 196, 196, 0.2)),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(196, 196, 196, 0.2)),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(196, 196, 196, 0.2)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_tabControllerOnboarding.index == 3)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Container(
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
                        width: double.infinity,
                        height: 52.h,
                        child: CupertinoButton(
                            child: Text(
                              'Join us for free',
                              style: textButtonStyle,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              addPreference(
                                  UserPreference(sawOnboarding: true));
                              if (Hive.box<UserPreference>('userpreference')
                                  .values
                                  .isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) => MyApp(),
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
