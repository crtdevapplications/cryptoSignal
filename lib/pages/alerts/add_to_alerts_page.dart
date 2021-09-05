import 'package:crypto_signal_app/pages/alerts/alert_edit_page.dart';
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

import '../../user.dart';

class AddToAlertsPage extends StatefulWidget {
  const AddToAlertsPage({Key? key}) : super(key: key);

  @override
  _AddToAlertsPageState createState() => _AddToAlertsPageState();
}

class _AddToAlertsPageState extends State<AddToAlertsPage> {
  Map<String, String> searchList = {};
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    searchList.addAll(listOfCryptos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        appBar: AppBar(
          title: Text(
            'New alert',
            style: textStyleHeader,
          ),
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
        ),
        body:SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: textFieldThemeData,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 0),
                    child: Container(
                      height: 42.h,
                      child: TextField(
                        onChanged: (value) {
                          _filterSearchResults(value);
                        },
                        controller: _editingController,
                        decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 18.w),
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
                Expanded(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20.h),
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 12.h),
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: cardBackground,
                            borderRadius: BorderRadius.circular(16.w),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.w, right: 12.w),
                                child: SvgPicture.asset(
                                  'assets/cryptoicons/' +
                                      searchList.keys
                                          .elementAt(index)
                                          .toLowerCase() +
                                      '.svg',
                                  width: 48.r,
                                  height: 48.r,
                                ),
                              ),
                              Text(
                                searchList.values.elementAt(index),
                                style: textStyleWhite,
                              ),
                              Spacer(),
                              CupertinoButton(
                                  child: SvgPicture.asset('assets/arrowright.svg'),
                                  onPressed: () { Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => AlertEditPage(searchList.keys
                                          .elementAt(index)),
                                    ),
                                  );})
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
void _filterSearchResults(String query) {
  Map<String, String> dummySearchList = {};
  dummySearchList.addAll(listOfCryptos);
  if (query.isNotEmpty) {
    Map<String, String> dummyListData = {};
    dummySearchList.forEach((key, value) {
      if (key.toLowerCase().contains(query.toLowerCase()) ||
          value.toLowerCase().contains(query.toLowerCase())) {
        Map<String, String> yetAnotherDummyList = {key: value};
        dummyListData.addAll(yetAnotherDummyList);
      }
    });
    setState(() {
      searchList.clear();
      searchList.addAll(dummyListData);
    });
    return;
  } else {
    setState(() {
      searchList.clear();
      searchList.addAll(listOfCryptos);
    });
  }
}
}
