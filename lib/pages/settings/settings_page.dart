import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/broker_ad_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:crypto_signal_app/pages/settings/terms_and_conditions_page.dart';
import 'package:crypto_signal_app/pages/settings/privacy_policy_page.dart';
import 'package:crypto_signal_app/pages/settings/how_to_use_app_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static final Map<Widget, String> _settingsPageMenus = <Widget, String>{
    const HowToUseAppPage(): 'How to use app',
    const NotificationPage(): 'Notifications',
    const TermsAndConditionsPage(): 'Terms and conditions',
    const PrivacyPolicyPage(): 'Privacy policy',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Theme(
      data: appThemeData,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.h, 12.h),
              child: Text(
                'Settings',
                style: textStyleHeader,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.h, 0),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: _settingsPageMenus.values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(16.r)),
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          children: [
                            Text(
                              _settingsPageMenus.values.toList().elementAt(index),
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
                              builder: (context) => _settingsPageMenus.keys.elementAt(index),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            brokerAd(false),
          ],
        ),
      ),
    ));
  }
}
