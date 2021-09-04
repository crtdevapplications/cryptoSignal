import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/crypto_api.dart';
import 'package:crypto_signal_app/onboarding.dart';
import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/remote_config_service.dart';
import 'dart:convert';
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/user_preference.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/pages/login_page/login_page.dart';
import 'package:crypto_signal_app/pages/settings/settings_page.dart';
import 'package:crypto_signal_app/pages/watchlist/watchlist_page.dart';
import 'package:crypto_signal_app/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';
import 'package:hive/hive.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await setUpRemoteConfig(remoteConfig);
  listOfID =
      jsonDecode(remoteConfig.getString('aivix_id')) as Map<String, dynamic>;
  signalsFromFirestore = remoteConfig.getString('signals');
  Hive.registerAdapter(AppUserAdapter());
  Hive.registerAdapter(UserPreferenceAdapter());
  await Hive.openBox<AppUser>('appuser');
  await Hive.openBox<UserPreference>('userpreference');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 672),
        builder: () => ChangeNotifierProvider<AuthService>(
              create: (_) => AuthService(),
              child: CupertinoApp(
                title: 'Crypto Signal App',
                localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                  DefaultWidgetsLocalizations.delegate,
                  DefaultMaterialLocalizations.delegate,
                ],
                home: Builder(builder: (context) {
                  return Hive.box<UserPreference>('userpreference')
                          .values
                          .isEmpty
                      ? Onboarding()
                      : Consumer<AuthService>(
                          builder: (_, auth, __) =>
                              auth.isSignedIn ? HomePage() : LoginPage(),
                        );
                }),
                debugShowCheckedModeBanner: false,
              ),
            ));
  }
}
