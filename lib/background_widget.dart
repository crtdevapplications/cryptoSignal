import 'dart:ui';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/crypto_api.dart';
import 'package:crypto_signal_app/onboarding.dart';
import 'package:crypto_signal_app/pages/login_page/phonecode_picker.dart';
import 'package:crypto_signal_app/pages/signals/signal_service.dart';
import 'package:crypto_signal_app/remote_config_service.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:crypto_signal_app/user.dart';
import 'package:crypto_signal_app/user_preference.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'alert_service.dart';
import 'constants.dart';

class Background_Widget extends StatelessWidget {
  Widget child;

  Background_Widget( this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Container(
            color:  const Color.fromRGBO(20, 20, 34, 1),
          ),
          CustomPaint(painter: OpenPainter()),
          BackdropFilter(child: Container(), filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100) ,
          ),
          child,
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(74, 90, 255, 1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
