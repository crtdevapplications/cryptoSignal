import 'package:firebase_remote_config/firebase_remote_config.dart';

Future setUpRemoteConfig(RemoteConfig remoteConfig) async{
  remoteConfig.setDefaults(<String, dynamic>{
    'respawnTime': 14400,
  });
  remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 7),
    minimumFetchInterval: const Duration(hours: 0),
  ));
  await remoteConfig.fetchAndActivate();
}
