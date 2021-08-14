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

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static final Map<Widget, String> _settingsPageMenus = <Widget, String>{
    const HowToUseAppPage(): 'How to use app',
    const NotificationPage(): 'Notifications',
    const CalculateGainPage(): 'Potential Gain Calculator',
    const TermsAndConditionsPage(): 'Terms and conditions',
    const PrivacyPolicyPage(): 'Privacy policy',
  };

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: appThemeData,
      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                child: Text(
                  'Settings',
                  style: textStyleHeader,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: SettingsPage._settingsPageMenus.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(16.r),
                        color: cardBackground,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            Text(
                              SettingsPage._settingsPageMenus.values.toList().elementAt(index),
                              style: textButtonStyle,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/arrowright.svg',
                              height: 24.r,
                              width: 24.r,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => SettingsPage._settingsPageMenus.keys.elementAt(index),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              const brokerAd(false),
            ],
          ),
    );
  }
}
