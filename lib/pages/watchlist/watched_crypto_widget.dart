import 'package:crypto_signal_app/crypto_api.dart';
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
import 'package:crypto_signal_app/pages/watchlist/add_to_watchlist_page.dart';

class WatchedCryptoWidget extends StatelessWidget {
  CryptoApi cryptoApi;
  WatchedCryptoWidget(this.cryptoApi, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
          SvgPicture.asset('assets/cryptoicons/'+cryptoApi.symbol.toLowerCase()+'.svg', height: 48.r, width: 48.r,),
          SizedBox(width: 12.w,),
          Text(cryptoApi.symbol.toUpperCase()+'/USD', style: textButtonStyle,),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('\$'+cryptoApi.currentPrice.toString(), style: textButtonStyle,),
              Text(cryptoApi.percentChange != 'null' ? cryptoApi.percentChange+'%': '0%', style: cryptoApi.gain == true ? textGainGreen : textGainRed,),
            ],
          )
        ],
      ),
    );
  }
}
