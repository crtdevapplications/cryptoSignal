import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _allNotificationSwitchValue=true;
  bool _signalNotificationSwitchValue=true;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appThemeData,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Notifications', style: textStyleHeader,),
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
        ),
        backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(16.r)
                  ),
                  padding: EdgeInsets.fromLTRB(16.w, 0, 9.w, 0),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text('All notifications', style: textButtonStyle,),
                      trailing: Switch(
                        splashRadius: 0,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color.fromRGBO(196, 196, 196, 1),
                        value: _signalNotificationSwitchValue,
                        thumbColor: _signalNotificationSwitchValue == false ?  MaterialStateProperty.all(Color.fromRGBO(196, 196, 196, 1)): MaterialStateProperty.all(Color.fromRGBO(84, 122, 255, 1)),
                        onChanged: (bool value){
                          setState(() {
                            _signalNotificationSwitchValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 9.w, 0),
                  height: 52.h,
                  decoration: BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text('Signal notifications', style: textButtonStyle,),
                      trailing: Switch(
                        splashRadius: 0,
                        activeTrackColor: Colors.white,
                        thumbColor: _allNotificationSwitchValue == false ?  MaterialStateProperty.all(Color.fromRGBO(196, 196, 196, 1)): MaterialStateProperty.all(Color.fromRGBO(84, 122, 255, 1)),
                        inactiveTrackColor: Color.fromRGBO(196, 196, 196, 1),
                        value: _allNotificationSwitchValue,
                        onChanged: (bool value){
                          setState(() {
                            _allNotificationSwitchValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
