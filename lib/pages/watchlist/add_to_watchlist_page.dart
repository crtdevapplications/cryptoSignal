import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hive/hive.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';
import 'package:crypto_signal_app/pages/settings/calculate_gain_page.dart';
import 'package:hive/hive.dart';

class AddToWatchlistPage extends StatefulWidget {
  const AddToWatchlistPage({Key? key}) : super(key: key);

  @override
  _AddToWatchlistPageState createState() => _AddToWatchlistPageState();
}

class _AddToWatchlistPageState extends State<AddToWatchlistPage> {
  Map<String, String> searchList = {};
  TextEditingController editingController = TextEditingController();

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
            'Add to watchlist',
            style: textStyleHeader,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          titleSpacing: 0,
        ),
        body: SafeArea(
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
                  child: Stack(
                    children: [
                      TextField(
                        onChanged: (value) {
                          _filterSearchResults(value);
                        },
                        controller: editingController,
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
                    ],
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
                              child: SvgPicture.asset(
                                  Hive.box<AppUser>('appuser')
                                              .values
                                              .first
                                              .listOfWatchedCryptos
                                              .contains(searchList.keys
                                                  .elementAt(index)
                                                  .toUpperCase()) ==
                                          true
                                      ? 'assets/greencheckmark.svg'
                                      : 'assets/white_plus.svg'),
                              onPressed: () {
                                if (Hive.box<AppUser>('appuser')
                                            .values
                                            .first
                                            .listOfWatchedCryptos
                                            .length <=
                                        4) {
                                  if (Hive.box<AppUser>('appuser')
                                      .values
                                      .first
                                      .listOfWatchedCryptos
                                      .contains(searchList.keys
                                          .elementAt(index)
                                          .toUpperCase())) {
                                    deleteWatchedCrypto(searchList.keys
                                        .elementAt(index)
                                        .toUpperCase());
                                    setState(() {});
                                  } else {
                                    updateWatchedCrypto(searchList.keys
                                        .elementAt(index)
                                        .toUpperCase());
                                    setState(() {});
                                  }
                                }
                                else if(Hive.box<AppUser>('appuser')
                                    .values
                                    .first
                                    .listOfWatchedCryptos
                                    .length >=
                                    4 && Hive.box<AppUser>('appuser')
                                    .values
                                    .first
                                    .listOfWatchedCryptos
                                    .contains(searchList.keys
                                    .elementAt(index)
                                    .toUpperCase())){
                                  deleteWatchedCrypto(searchList.keys
                                      .elementAt(index)
                                      .toUpperCase());
                                  setState(() {});
                                }
                                else{
                                  print('Too many cryptos for u');
                                  setState(() {});
                                }
                              })
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
