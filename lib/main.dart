import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/pages/login_page/login_page.dart';
import 'package:crypto_signal_app/pages/settings/settings_page.dart';
import 'package:crypto_signal_app/pages/watchlist/watchlist_page.dart';
import 'package:crypto_signal_app/home_page.dart';

import 'package:crypto_signal_app/pages/settings/notification_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 672),
        builder: () => const CupertinoApp(
          title: 'Crypto Signal App',
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
          home:
           // LoginPage(),
          HomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
