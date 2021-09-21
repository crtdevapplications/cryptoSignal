import 'package:amplitude_flutter/amplitude.dart';
import 'package:crypto_signal_app/alert_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:crypto_signal_app/auth_service.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class AppUser extends HiveObject {
  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.countryPhoneCode,
    required this.phoneNumber,
    required this.countryISO,
    required this.leadIP,
    required this.landDomain,
    required this.affiliateID,
    required this.offerID,
    required this.dateTime,
    required this.uid,
    required this.listOfWatchedCryptos,
    required this.brokerAdURL,
    required this.listOfAlertCryptos
  });

  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String countryPhoneCode;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String countryISO;
  @HiveField(7)
  String leadIP;
  @HiveField(8)
  String landDomain;
  @HiveField(9)
  String affiliateID;
  @HiveField(10)
  String offerID;
  @HiveField(11)
  DateTime dateTime;
  @HiveField(12)
  String uid;
  @HiveField(13)
  List<String> listOfWatchedCryptos = <String>[];
  @HiveField(14)
  String brokerAdURL;
  @HiveField(15)
  List<Alert> listOfAlertCryptos = <Alert>[];
}

void addUser(AppUser user) {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  userBox.put(0, user);
}
AuthService _authService = AuthService();

void updateWatchedCrypto(String crypto) async {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  List<String> currentlyWatchedCryptos = [crypto];
  if(userBox.getAt(0)!.listOfWatchedCryptos.isNotEmpty){
    currentlyWatchedCryptos.addAll(userBox.getAt(0)!.listOfWatchedCryptos);
  }
  AppUser updatedUser = AppUser(
      firstName: userBox.getAt(0)!.firstName,
      lastName: userBox.getAt(0)!.lastName,
      email: userBox.getAt(0)!.email,
      password: userBox.getAt(0)!.password,
      countryPhoneCode: userBox.getAt(0)!.countryPhoneCode,
      phoneNumber: userBox.getAt(0)!.phoneNumber,
      countryISO: userBox.getAt(0)!.countryISO,
      leadIP: userBox.getAt(0)!.leadIP,
      landDomain: userBox.getAt(0)!.landDomain,
      affiliateID: userBox.getAt(0)!.affiliateID,
      offerID: userBox.getAt(0)!.offerID,
      dateTime: userBox.getAt(0)!.dateTime,
      uid: userBox.getAt(0)!.uid,
      listOfWatchedCryptos: currentlyWatchedCryptos,
      brokerAdURL: userBox.getAt(0)!.brokerAdURL,
      listOfAlertCryptos: userBox.getAt(0)!.listOfAlertCryptos
  );
  userBox.put(0, updatedUser);
  Amplitude.getInstance(instanceName: "crypto-signal")
      .logEvent('crypto_added_to_watchlist', eventProperties: <String, dynamic>{
    'name': crypto});
  FirebaseAnalytics().logEvent(
      name: 'crypto_added_to_watchlist',
      parameters: {
        'name': crypto
      });
  // Обновляет (добавляет в этой функции) данные о watched криптах на фаерстор
  // await _authService.updateUserData(updatedUser, userBox.getAt(0)!.uid);
}
void deleteWatchedCrypto(String crypto) async {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  userBox.getAt(0)!.listOfWatchedCryptos.removeWhere((element) => element == crypto);
  List<String>currentlyWatchedCryptos = userBox.getAt(0)!.listOfWatchedCryptos;
  AppUser updatedUser = AppUser(
      firstName: userBox.getAt(0)!.firstName,
      lastName: userBox.getAt(0)!.lastName,
      email: userBox.getAt(0)!.email,
      password: userBox.getAt(0)!.password,
      countryPhoneCode: userBox.getAt(0)!.countryPhoneCode,
      phoneNumber: userBox.getAt(0)!.phoneNumber,
      countryISO: userBox.getAt(0)!.countryISO,
      leadIP: userBox.getAt(0)!.leadIP,
      landDomain: userBox.getAt(0)!.landDomain,
      affiliateID: userBox.getAt(0)!.affiliateID,
      offerID: userBox.getAt(0)!.offerID,
      dateTime: userBox.getAt(0)!.dateTime,
      uid: userBox.getAt(0)!.uid,
      listOfWatchedCryptos: currentlyWatchedCryptos,
      brokerAdURL: userBox.getAt(0)!.brokerAdURL,
      listOfAlertCryptos: userBox.getAt(0)!.listOfAlertCryptos
  );
  userBox.put(0, updatedUser);
  Amplitude.getInstance(instanceName: "crypto-signal")
      .logEvent('crypto_deleted_from_watchlist', eventProperties: <String, dynamic>{
    'name': crypto});
  FirebaseAnalytics().logEvent(
      name: 'crypto_deleted_from_watchlist',
      parameters: {
        'name': crypto
      });
  // Обновляет (удаляет в этой функции) данные о watched криптах на фаерстор
  // await _authService.updateUserData(updatedUser, userBox.getAt(0)!.uid);
}
void updateAlertCrypto(Alert alert) async {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  List<Alert> currentlyAlertCryptos = [alert];
  if(userBox.getAt(0)!.listOfAlertCryptos.isNotEmpty){
    currentlyAlertCryptos.addAll(userBox.getAt(0)!.listOfAlertCryptos);
  }
  AppUser updatedUser = AppUser(
      firstName: userBox.getAt(0)!.firstName,
      lastName: userBox.getAt(0)!.lastName,
      email: userBox.getAt(0)!.email,
      password: userBox.getAt(0)!.password,
      countryPhoneCode: userBox.getAt(0)!.countryPhoneCode,
      phoneNumber: userBox.getAt(0)!.phoneNumber,
      countryISO: userBox.getAt(0)!.countryISO,
      leadIP: userBox.getAt(0)!.leadIP,
      landDomain: userBox.getAt(0)!.landDomain,
      affiliateID: userBox.getAt(0)!.affiliateID,
      offerID: userBox.getAt(0)!.offerID,
      dateTime: userBox.getAt(0)!.dateTime,
      uid: userBox.getAt(0)!.uid,
      listOfWatchedCryptos: userBox.getAt(0)!.listOfWatchedCryptos,
      brokerAdURL: userBox.getAt(0)!.brokerAdURL,
      listOfAlertCryptos: currentlyAlertCryptos
  );
  userBox.put(0, updatedUser);
  // Обновляет (добавляет в этой функции) данные о watched криптах на фаерстор
  // await _authService.updateUserData(updatedUser, userBox.getAt(0)!.uid);
}
void deleteAlertCrypto(Alert alert) async {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  userBox.getAt(0)!.listOfAlertCryptos.removeWhere((element) => element == alert);
  List<Alert>currentlyAlertCryptos = userBox.getAt(0)!.listOfAlertCryptos;
  AppUser updatedUser = AppUser(
      firstName: userBox.getAt(0)!.firstName,
      lastName: userBox.getAt(0)!.lastName,
      email: userBox.getAt(0)!.email,
      password: userBox.getAt(0)!.password,
      countryPhoneCode: userBox.getAt(0)!.countryPhoneCode,
      phoneNumber: userBox.getAt(0)!.phoneNumber,
      countryISO: userBox.getAt(0)!.countryISO,
      leadIP: userBox.getAt(0)!.leadIP,
      landDomain: userBox.getAt(0)!.landDomain,
      affiliateID: userBox.getAt(0)!.affiliateID,
      offerID: userBox.getAt(0)!.offerID,
      dateTime: userBox.getAt(0)!.dateTime,
      uid: userBox.getAt(0)!.uid,
      listOfWatchedCryptos: userBox.getAt(0)!.listOfWatchedCryptos,
      brokerAdURL: userBox.getAt(0)!.brokerAdURL,
      listOfAlertCryptos: currentlyAlertCryptos
  );
  userBox.put(0, updatedUser);
  // Обновляет (удаляет в этой функции) данные о watched криптах на фаерстор
  // await _authService.updateUserData(updatedUser, userBox.getAt(0)!.uid);
}