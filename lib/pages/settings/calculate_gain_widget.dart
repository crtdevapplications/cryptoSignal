import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/pages/signals/signals_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:hive/hive.dart';

import '../../crypto_api.dart';
import '../../user.dart';

class CalculateGainWidget extends StatefulWidget {
  const CalculateGainWidget({Key? key}) : super(key: key);

  @override
  _CalculateGainWidgetState createState() => _CalculateGainWidgetState();
}

class _CalculateGainWidgetState extends State<CalculateGainWidget> {
  late Future<List<CryptoApi>> dataFromApi;
  double unrealizedGains = 0;

  @override
  void initState() {
    // listOfFilteredOpenSignals.forEach((element) {
    //   tempList.add((element.symbol)!);
    // });
    dataFromApi = getCryptosFromById(tempList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([dataFromApi]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (!snapshot.hasData) {
            return Container(
              alignment: AlignmentDirectional.center,
              child: Container(
                height: 52.r,
                width: 52.r,
                child: CircularProgressIndicator(
                  strokeWidth: 7.w,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            List<CryptoApi> listOfWatchlistCryptos =
            (snapshot.data as List)[0] as List<CryptoApi>;
            List<double> listLostPuk = [];
            for(int i = 0; i < tempList.length; i++ )
              {
                listLostPuk.add(listOfWatchlistCryptos.where((element) => element.symbol.toLowerCase() == tempList.elementAt(i).toLowerCase()).first.currentPrice);
              }
            if(listLostPuk.isNotEmpty){
              unrealizedGains = 0;
              for(int i = 0; i < tempListForExitPrices.length; i++) {
                unrealizedGains +=
                    getPercentageChange(tempListForExitPrices.elementAt(i), listLostPuk.elementAt(i));
                // print(unrealizedGains);
              }
            }
          }
          return Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(16.r)),
            child: Center(
                child: Text(
                  unrealizedGains.toStringAsFixed(2) + '\%',
                  style: textGainGreen,
                )),
          );
        });
  }
}
