import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';
import 'package:crypto_signal_app/pages/settings/calculate_gain_page.dart';
import 'package:crypto_signal_app/pages/watchlist/add_to_watchlist_page.dart';
import 'package:crypto_signal_app/pages/watchlist/watched_crypto_widget.dart';

import '../../crypto_api.dart';
import '../../user.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with AutomaticKeepAliveClientMixin {
  late Future<List<CryptoApi>> dataFromApi;


  @override
  void initState() {
    if(Hive.box<AppUser>('appuser').values.first.listOfWatchedCryptos.isNotEmpty){
    dataFromApi = getCryptosFromById(
        Hive.box<AppUser>('appuser').values.first.listOfWatchedCryptos);}
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    if (Hive
        .box<AppUser>('appuser')
        .values
        .first
        .listOfWatchedCryptos
        .isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your watchlist is currently empty',
              style: textStyleHeader,
            ),
            SizedBox(
              height: 12.h,
            ),
            CupertinoButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const AddToWatchlistPage(),
                  ),
                );
                if (Hive
                    .box<AppUser>('appuser')
                    .values
                    .first
                    .listOfWatchedCryptos
                    .isNotEmpty) {
                  dataFromApi = getCryptosFromById(
                      Hive
                          .box<AppUser>('appuser')
                          .values
                          .first
                          .listOfWatchedCryptos);
                }
                setState(() {});
              },
              padding: EdgeInsets.zero,
              child: Container(
                height: 52.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [buttonGradientStart, buttonGradientEnd]),
                    borderRadius: BorderRadius.circular(16.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add crypto to watchlist',
                        style: textButtonStyle,
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/plus.svg',
                        height: 24.r,
                        width: 24.r,
                        color: svgPicturesColor,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return FutureBuilder(
          future: Future.wait([dataFromApi]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Network error.',
                        style: richTextRegular,
                      ),
                      SizedBox(height: 10.w),
                      Container(
                        width: 90.w,
                        height: 37.h,
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
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            dataFromApi = getCryptosFromById(
                                Hive
                                    .box<AppUser>('appuser')
                                    .values
                                    .first
                                    .listOfWatchedCryptos);
                            setState(() {});
                          },
                          child: Text(
                            'Try again',
                            style: richTextRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Container(
                alignment: AlignmentDirectional.center,
                child: Container(
                  height: 120.r,
                  width: 120.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 7.w,
                    color: Colors.white,
                  ),
                ),
              );
            }
            else {
              List<CryptoApi> listOfWatchlistCryptos =
              (snapshot.data as List)[0] as List<CryptoApi>;
              return Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 11.w,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Watchlist',
                            style: textStyleHeader,
                          ),
                          const Spacer(),
                          CupertinoButton(
                            child: Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                'assets/plus.svg',
                                color: Colors.white,
                                height: 24.r,
                                width: 24.r,
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) =>
                                  const AddToWatchlistPage(),
                                ),
                              );
                              if (Hive
                                  .box<AppUser>('appuser')
                                  .values
                                  .first
                                  .listOfWatchedCryptos
                                  .isNotEmpty) {
                                dataFromApi = getCryptosFromById(
                                    Hive
                                        .box<AppUser>('appuser')
                                        .values
                                        .first
                                        .listOfWatchedCryptos);
                              }
                              setState(() {});
                            },
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                        ),
                        child: ListView.builder(
                          itemCount: listOfWatchlistCryptos.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: WatchedCryptoWidget(
                                  listOfWatchlistCryptos.elementAt(index)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          });
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
//   void apiActions() async{
//     if(Hive.box<AppUser>('appuser').values.first.listOfWatchedCryptos.isNotEmpty){
//       dataFromApi = ;}
//   }
// }
