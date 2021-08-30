import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';



String signalsFromFirestore = '';
Map<String, dynamic> listOfID = <String, dynamic>{};

String termsAndConditionsText =
    'www.cyptosignal.io\n\nThis disclaimer and these terms and conditions of use tell you how the Site is managed and how you are protected when you are using our Site, Application and/or our Services.\n\nThese terms and conditions of use and disclaimer, together with the terms of the Privacy Policy available at www.cyptosignal.io ”) (collectively, these “\nRisk Warning: Trading Cryptos is potentially full of high risk and may not be suitable for all investors. The high level of leverage can work both for and against traders. Before any investment you need to carefully consider your targets, previous experience, and risk level. Trading can result in the loss of your money, as a result, you are expressly cautioned that you should never invest or trade with money that you cannot afford to lose. Last Modified: May 1 2021”) form an integral part of any use of the Site or our Services, as such terms are defined below, and you agree to be bound by them and to comply with all applicable laws and regulations regarding your use of the Site and the Services and you acknowledge that even though these Terms of Use are electronic and are not physically signed by you and the Company, these terms of use constitute a binding and enforceable legal contract between the Company and you.\nRisk Warning: Trading Cryptos is potentially full of high risk and may not be suitable for all investors. The high level of leverage can work both for and against traders. Before any investment you need to carefully consider your targets, previous experience, and risk level. Trading can result in the loss of your money, as a result, you are expressly cautioned that you should never invest or trade with money that you cannot afford to lose.\nIF YOU DO NOT AGREE WITH THESE TERMS OF USE, YOU SHOULD LEAVE THE SITE IMMEDIATELY.\nDISCLAIMER: The content of this website is intended to convey general information only. This website/app (hereinafter the “website”) does not provide legal, investment, tax, etc. advice. You should not treat any information as a call to make any particular decision regarding Crypto usage, legal matters, investments, taxes, exchange usage, wallet usage, etc. We strongly suggest seeking advice from your own financial, investment, tax, or legal adviser. Neither this website nor its parent companies accept any responsibility for any loss, damage, or inconvenience caused as a result of reliance on information published on, or linked to the website.\nNO FINANCIAL ADVICE \nThe Information on this website is provided for education and informational purposes only, without any express or implied warranty of any kind, including warranties of accuracy, completeness, or fitness for any particular purpose. The Information contained in or provided from or through this website is not intended to be and does not constitute financial advice, investment advice, trading advice or any other advice. The Information on this website and provided from or through this website is general in nature and is not specific to you the User or anyone else. You should not make any decision, financial, investment, trading or otherwise, based on any of the information presented on this website without undertaking independent due diligence and consultation with a professional broker or financial advisory. You understand that you are using any and all Information available on or through this website at your own risk. The information provided on this website does not constitute investment advice, financial advice, trading advice or any other sort of advice and you should not treat any of the website’s content as such. The Website does not recommend that any Crypto should be bought, sold or held by you and nothing on this website should be taken as an offer to buy, sell or hold a Crypto. Do conduct your own due-diligence and consult your financial advisory before making any investment decision.';
String privacyAndPolicyText =
    'Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.\n\nBla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.\n\nBla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla-Bla-bla-bla.';
Color buttonGradientStart = const Color.fromRGBO(84, 122, 255, 1);
Color buttonGradientEnd = const Color.fromRGBO(65, 61, 255, 1);
Color textGreen = const Color.fromRGBO(0, 255, 41, 1);
Color textRed = const Color.fromRGBO(255, 97, 97, 1);
Color textBlue = const Color.fromRGBO(51, 182, 255, 1);
Color textDefault = const Color.fromRGBO(252, 252, 252, 1);
Color cardBackground = const Color.fromRGBO(34, 36, 51, 0.8);
Color textShaded = const Color.fromRGBO(252, 252, 252, 0.4);
Color checkboxColor = const Color.fromRGBO(71, 71, 81, 1);
Color textFieldBorderColor = const Color.fromRGBO(255, 255, 255, 0.4);
Color textFocused = const Color.fromRGBO(252, 252, 252, 1);
Color svgPicturesColor = const Color.fromRGBO(30, 30, 32, 1);
Color signalWidgetShaded = const Color.fromRGBO(252, 252, 252, 0.64);
Color textPlaceholder = const Color.fromRGBO(255, 255, 255, 0.2);
Color textBlack = const Color.fromRGBO(26, 27, 39, 1);
Color bottomNavBarColor = const Color.fromRGBO(122, 124, 148, 1);
Color toggleButtonBorderColor = const Color.fromRGBO(255, 255, 255, 0.1);
TextStyle textStyleSignalDefault  =
TextStyle(color: textDefault, fontSize: 22.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleSignalGreen  =
TextStyle(color: textGreen, fontSize: 22.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleSignalRed  =
TextStyle(color: textRed, fontSize: 22.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleSignalShaded  =
TextStyle(color: signalWidgetShaded, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleSignalWidget =
TextStyle(color: signalWidgetShaded, fontSize: 12.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleHeader =
    TextStyle(color: textDefault, fontSize: 24.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleHeaderGreen =
    TextStyle(color: textGreen, fontSize: 24.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textStyleHeaderRed =
    TextStyle(color: textRed, fontSize: 24.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle richTextHeader =
    TextStyle(color: textDefault, fontSize: 20.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w700);
TextStyle richTextRegular =
    TextStyle(color: textDefault, fontSize: 16.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textButtonStyle =
    TextStyle(color: textDefault, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textGainGreen =
    TextStyle(color: textGreen, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textShadedStyle =
    TextStyle(color: textShaded, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500);
TextStyle textFieldStyle =
    TextStyle(color: textPlaceholder, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w500,);
TextStyle toggleButtonStyle = TextStyle(fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w400);
TextStyle errorStyle = TextStyle(fontSize: 12.sp, color: const Color.fromRGBO(167, 43, 47, 1), fontFamily: 'DMSans',  fontWeight: FontWeight.w600);
TextStyle bottomTabBarStyle = TextStyle(
    color: bottomNavBarColor, fontSize: 14.sp, fontFamily: 'DMSans', fontWeight: FontWeight.w400);
TextStyle textStyleShaded = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'DMSans',
  color: textShaded,
);
TextStyle textStyleWhite = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'DMSans',
  color: textDefault,
);
ThemeData appThemeData = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
);
ThemeData textFieldThemeData = ThemeData(
  textTheme: TextTheme(
    subtitle1: textButtonStyle,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: toggleButtonBorderColor,

    // errorStyle: errorStyle,
    filled: true,
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: toggleButtonBorderColor,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: toggleButtonBorderColor,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textFieldBorderColor)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.w),
    ),
    hintStyle: textFieldStyle,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: textDefault,
  ),
);
RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");