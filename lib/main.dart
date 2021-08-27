import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:crypto_signal_app/user.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AppUserAdapter());
  await Hive.openBox<AppUser>('appuser');
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
                home: Consumer<AuthService>(
                  builder: (_, auth, __) =>
                      // auth.isSignedIn ? LoginPage() :  LoginPage() ,
            auth.isSignedIn ? HomePage() :  LoginPage() ,
                ),
                debugShowCheckedModeBanner: false,
              ),
            ));
  }
}
