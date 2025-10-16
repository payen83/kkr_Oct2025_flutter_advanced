
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/app.dart';
import 'package:flutter_advanced_2025/app/constant/id.constant.dart';
import 'package:flutter_advanced_2025/firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  OneSignal.initialize(oneSignalID);
  // print(oneSignalID);
  OneSignal.Notifications.requestPermission(true);

  await Future.delayed(Duration(seconds: 5));
  OneSignal.User.pushSubscription;
  // print('result==>');

  // print(jsonEncode(test.toString()));

  runApp(const ShrineApp());
}
 