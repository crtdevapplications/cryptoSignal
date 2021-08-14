import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavTabbarWidget extends StatefulWidget {
  int selectedIndex;
  BottomNavTabbarWidget(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  _BottomNavTabbarWidgetState createState() => _BottomNavTabbarWidgetState();
}

class _BottomNavTabbarWidgetState extends State<BottomNavTabbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 54.h,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14.sp,
          unselectedFontSize: 14.sp,
          currentIndex: widget.selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: bottomNavBarColor,
          selectedLabelStyle: bottomTabBarStyle,
          unselectedLabelStyle: bottomTabBarStyle,
          onTap: (int index) {
            setState(() {
              widget.selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/signals.svg', color: widget.selectedIndex == 0 ? Colors.white : bottomNavBarColor, height: 24.r, width: 24.r,), label: 'Signals', tooltip: 'Signals',),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/watchlist.svg', color: widget.selectedIndex == 1 ? Colors.white : bottomNavBarColor, height: 24.r, width: 24.r,), label: 'Watchlist'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/alerts.svg', color: widget.selectedIndex == 2 ? Colors.white : bottomNavBarColor, width: 24.r,), label: 'Alerts'),
            BottomNavigationBarItem(icon: SvgPicture.asset('assets/settings.svg',color: widget.selectedIndex == 3 ? Colors.white : bottomNavBarColor, height: 24.r, width: 24.r,), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
