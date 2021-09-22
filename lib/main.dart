import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/crypto_api.dart';
import 'package:crypto_signal_app/onboarding.dart';
import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/remote_config_service.dart';
import 'dart:convert';
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/user_preference.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'alert_service.dart';
import 'constants.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Paint.enableDithering = true;
  try {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    await setUpRemoteConfig(remoteConfig);
    listOfID =
        jsonDecode(remoteConfig.getString('aivix_id')) as Map<String, dynamic>;
    apiBrokerUrl = listOfID.values.elementAt(2).toString();
    signalsFromFirestore = remoteConfig.getString('signals');
  }  catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
  }
  Hive.registerAdapter(AppUserAdapter());
  Hive.registerAdapter(UserPreferenceAdapter());
  Hive.registerAdapter(AlertAdapter());
  Hive.registerAdapter(SignalAdapter());
  await Hive.openBox<AppUser>('appuser');
  await Hive.openBox<UserPreference>('userpreference');
  await Hive.openBox<List <Signal>>('signals');
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  final Amplitude analytics = Amplitude.getInstance(instanceName: "crypto-signal");
  analytics.init(amplitudeKey);
  Amplitude.getInstance(instanceName: "crypto-signal").logEvent('app_started');
  FirebaseAnalytics()
      .logEvent(name: 'app_started', parameters: null);
  // print(Hive.box<AppUser>('appuser').values.first.listOfWatchedCryptos);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 672),
        builder: () => ChangeNotifierProvider <AuthService>(
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
                              auth.isSignedIn ? HomePage(0) : LoginPage(),
                        );
                }),
                debugShowCheckedModeBanner: false,
              ),
            ));
  }
}
