import 'package:hive/hive.dart';
import 'dart:io';
part 'user_preference.g.dart';

@HiveType(typeId: 1)
class UserPreference extends HiveObject {
  UserPreference({
    required this.sawOnboarding,
  });

  @HiveField(0)
  bool sawOnboarding;
}

void addPreference(UserPreference preference) {
  final Box<UserPreference> preferenceBox = Hive.box<UserPreference>('userpreference');
  preferenceBox.put(0, preference);
}
