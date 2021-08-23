import 'package:hive/hive.dart';
import 'dart:io';

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
    required this.uid
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
}

void addUser(AppUser user) {
  final Box<AppUser> userBox = Hive.box<AppUser>('appuser');
  userBox.put(0, user);
}
