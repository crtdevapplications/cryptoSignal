import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:crypto_signal_app/pages/settings/notification_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 34, 1),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.h, 0),
            child: Text('Settings', style: textStyleHeader,),
          ),
          CupertinoButton(
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const NotificationPage(),
                ),
              );},
              child: Text('123')),
        ],
      ),
    ));
  }
}
