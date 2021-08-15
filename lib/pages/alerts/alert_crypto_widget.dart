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

class AlertCryptoWidget extends StatelessWidget {
  String cryptoCode;
  bool goingUp;
  double price;
  double percentageChanged;
  AlertCryptoWidget(this.cryptoCode, this.goingUp, this.price, this.percentageChanged, {Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/cryptoicons/'+cryptoCode+'.svg', height: 48.r, width: 48.r,),
          SizedBox(width: 12.w,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(cryptoCode.toUpperCase()+'/USD', style: textStyleHeader,),
              Text(cryptoCode+'/US Dollar', style: textButtonStyle,),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('\$'+price.toString(), style: textButtonStyle,),
              Text(percentageChanged.toStringAsFixed(6)+'%', style: goingUp == true ? textGainGreen : textButtonStyle,),
            ],
          )
        ],
      ),
    );
  }
}
