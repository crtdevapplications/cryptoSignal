import 'package:crypto_signal_app/auth_service.dart';
import 'package:crypto_signal_app/constants.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:crypto_signal_app/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:crypto_signal_app/phonecode.dart';

class PhonecodePicker extends StatefulWidget {
  const PhonecodePicker({Key? key}) : super(key: key);

  @override
  _PhonecodePickerState createState() => _PhonecodePickerState();
}

class _PhonecodePickerState extends State<PhonecodePicker> {
  TextEditingController editingController = TextEditingController();
  List<PhoneCode> list2 = [];

  @override
  void initState() {
    list2.addAll(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Theme(
                  data: textFieldThemeData,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      height: 42.h,
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                          hintText: 'Search country',
                          suffixIcon: CupertinoButton(
                            child: SvgPicture.asset(
                              'assets/loupe.svg',
                            ),
                            onPressed: () {
                              setState(() {
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                      ),
                    ),
                  )),
              Expanded(
                child: ListView.builder(
                  // controller: ScrollController(),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  primary: true,
                  itemCount: list2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Theme(
                      data: appThemeData,
                      child: Container(
                        height: 42.h,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 16,
                          onTap: () {
                            Navigator.of(context).pop(<String>[list2[index].alpha_2_code, list2[index].dial_code]);
                          },
                          trailing: Text(
                            list2[index].dial_code,
                            style: richTextRegular,
                          ),
                          title: Text(
                            list2[index].en_short_name,
                            style: richTextRegular,
                          ),
                          leading: SizedBox(
                              height: 24.r,
                              width: 24.r,
                              child: Image.asset(
                                'assets/flags/' +
                                    list2[index].alpha_2_code.toLowerCase() +
                                    '.png',
                              )),
                        ),
                      ),
                    );

                    // CupertinoButton(
                    // padding: EdgeInsets.zero,
                    //   onPressed: () {},
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 52.h,
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           list[index].dial_code,
                    //           style: richTextRegular,
                    //         ),
                    //         Text(
                    //           list[index].en_short_name,
                    //           style: richTextRegular,
                    //         ),
                    //         Spacer(),
                    //         SizedBox(height: 24.r, width: 24.r, child: Image.asset('assets/flags/'+ list[index].alpha_2_code.toLowerCase() +'.png',)),
                    //
                    //       ],
                    //     ),
                    //   ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List<String> list2 = list.map((phonecode) => phonecode.en_short_name).toList();

  void filterSearchResults(String query) {
    List<PhoneCode> dummySearchList = [];
    dummySearchList.addAll(list);
    if (query.isNotEmpty) {
      List<PhoneCode> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.en_short_name.toLowerCase().contains(query) || item.alpha_3_code.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        list2.clear();
        list2.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        list2.clear();
        list2.addAll(list);
      });
    }
  }
}

Future<List<String>?> showPhonePickerBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<List<String>>(
      isScrollControlled: true,
      backgroundColor: const Color.fromRGBO(20, 20, 34, 1),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.w),
          topRight: Radius.circular(4.w),
        ),
      ),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: PhonecodePicker(),
          ),
        );
      });
}
