import 'package:crypto_signal_app/pages/signals/long_term_page.dart';
import 'package:crypto_signal_app/pages/signals/short_term_page.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/pages/signals/signals_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';
import 'package:crypto_signal_app/pages/settings/calculate_gain_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../user.dart';

class SignalsPage extends StatefulWidget {
  const SignalsPage({Key? key}) : super(key: key);

  @override
  _SignalsPageState createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage>
    with TickerProviderStateMixin {
  TextEditingController _editingController = TextEditingController();
  late TabController _tabController;
  late String userName;
  late int currentTime;


  @override
  void initState() {

    userName = toBeginningOfSentenceCase(
        Hive
            .box<AppUser>('appuser')
            .values
            .first
            .firstName)!;
    currentTime = DateTime
        .now()
        .hour;
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (currentTime >= 0 && currentTime < 11)
                    SvgPicture.asset('assets/morning.svg'),
                  if (currentTime >= 11 && currentTime < 19)
                    SvgPicture.asset('assets/day.svg'),
                  if (currentTime >= 19 && currentTime <= 23)
                    SvgPicture.asset('assets/night.svg'),
                  SizedBox(width: 8.w,),
                  RichText(
                    text: TextSpan(style: textStyleHeader, children: [
                      TextSpan(text: 'Good'),
                      if (currentTime >= 0 && currentTime < 7)
                        TextSpan(text: ' night '),
                      if (currentTime > 7 && currentTime < 11)
                        TextSpan(text: ' morning '),
                      if (currentTime >= 11 && currentTime < 19)
                        TextSpan(text: ' day '),
                      if (currentTime >= 19 && currentTime <= 23)
                        TextSpan(text: ' evening '),
                      TextSpan(text: userName),
                    ]),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            Theme(
              data: textFieldThemeData,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0),
                child: Container(
                  height: 42.h,
                  child: TextField(
                    onChanged: (value) {
                    filterSearchResults(value);},
                    controller: _editingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                        hintText: 'Search Crypto',
                        suffixIcon: CupertinoButton(
                          child: SvgPicture.asset(
                            'assets/loupe.svg',
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    border:
                    Border.all(color: toggleButtonBorderColor, width: 1)),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {});
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.white,
                  labelStyle: toggleButtonStyle,
                  labelColor: textBlack,
                  indicator: _tabController.index == 0
                      ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.w),
                      topLeft: Radius.circular(4.w),
                    ),
                  )
                      : BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4.w),
                      topRight: Radius.circular(4.w),
                    ),
                  ),
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Short-Term',
                            style: toggleButtonStyle,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Long-Term', style: toggleButtonStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    LongTermPage('short'),
                    LongTermPage('long'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void filterSearchResults(String query) {

    List<Signal> dummyOpenSignalsSearchList = [];
    List<Signal> dummyClosedSignalsSearchList = [];
    dummyOpenSignalsSearchList.addAll(listOfOpenSignals);
    dummyClosedSignalsSearchList.addAll(listOfClosedSignals);
    if (query.isNotEmpty) {
      List<Signal> dummyOpenSignalsListData = [];
      List<Signal> dummyClosedSignalsListData = [];
      dummyOpenSignalsSearchList.forEach((item) {
        if (item.symbol!.toLowerCase().contains(query) || item.name!.toLowerCase().contains(query)) {
          dummyOpenSignalsListData.add(item);
        }
      });
      dummyClosedSignalsSearchList.forEach((item) {
        if (item.symbol!.toLowerCase().contains(query) || item.name!.toLowerCase().contains(query)) {
          dummyClosedSignalsListData.add(item);
        }
      });
      setState(() {
        listOfFilteredClosedSignals.clear();
        listOfFilteredOpenSignals.clear();
        listOfFilteredClosedSignals.addAll(dummyClosedSignalsListData);
        listOfFilteredOpenSignals.addAll(dummyOpenSignalsListData);
      });
      return;
    } else {
      setState(() {
        listOfFilteredClosedSignals.clear();
        listOfFilteredOpenSignals.clear();
        fillTheLists();
      });
    }
  }
}

