import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/pages/watchlist/watchlist_page.dart';
import 'package:crypto_signal_app/pages/settings/settings_page.dart';
import 'package:crypto_signal_app/pages/alerts/alerts_page.dart';
import 'package:crypto_signal_app/pages/signals/signals_page.dart';
import 'package:hive/hive.dart';

import 'background_widget.dart';
import 'crypto_api.dart';

class HomePage extends StatefulWidget {
  int startingIndex;

  HomePage(this.startingIndex, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late int _selectedIndex;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<StatefulWidget> listOfPages = [
    const SignalsPage(),
    const WatchlistPage(),
    // const AlertsPage(),
    const SettingsPage()
  ];

  @override
  void initState() {
    listOfFilteredOpenSignals.clear();
    listOfFilteredClosedSignals.clear();
    try {
      getSignals();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    // print(listOfFilteredOpenSignals.first.name);
    _selectedIndex = widget.startingIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: SizedBox(
            height: 57.h,
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14.sp,
              unselectedFontSize: 14.sp,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: bottomNavBarColor,
              selectedLabelStyle: bottomTabBarStyle,
              unselectedLabelStyle: bottomTabBarStyle,
              onTap: (int index) {
                setState(() {
                  // _selectedIndex = index;
                  pageController.jumpToPage(index);
                  if (index == 0) {
                    Amplitude.getInstance(instanceName: "crypto-signal")
                        .logEvent('signals_tab_click');
                    FirebaseAnalytics()
                        .logEvent(name: 'signals_tab_click', parameters: null);
                  }
                  if (index == 1) {
                    Amplitude.getInstance(instanceName: "crypto-signal")
                        .logEvent('watchlist_tab_click');
                    FirebaseAnalytics().logEvent(
                        name: 'watchlist_tab_click', parameters: null);
                  }
                  if (index == 2) {
                    Amplitude.getInstance(instanceName: "crypto-signal")
                        .logEvent('settings_tab_click');
                    FirebaseAnalytics()
                        .logEvent(name: 'settings_tab_click', parameters: null);
                  }
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/signals.svg',
                    color:
                        _selectedIndex == 0 ? Colors.white : bottomNavBarColor,
                    height: 24.r,
                    width: 24.r,
                  ),
                  label: 'Signals',
                  tooltip: 'Signals',
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/watchlist.svg',
                      color: _selectedIndex == 1
                          ? Colors.white
                          : bottomNavBarColor,
                      height: 24.r,
                      width: 24.r,
                    ),
                    label: 'Watchlist'),
                //алерты пока выключены
                // BottomNavigationBarItem(icon: SvgPicture.asset('assets/alerts.svg', color: _selectedIndex == 2 ? Colors.white : bottomNavBarColor, width: 24.r,), label: 'Alerts'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/settings.svg',
                      color: _selectedIndex == 2
                          ? Colors.white
                          : bottomNavBarColor,
                      height: 24.r,
                      width: 24.r,
                    ),
                    label: 'Settings'),
              ],
            ),
          ),
        ),
        body: Background_Widget(
          SafeArea(
            child: PageView(
              children: listOfPages,
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
