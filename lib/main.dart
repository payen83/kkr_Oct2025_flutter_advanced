import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/app.dart';
import 'package:flutter_advanced_2025/app/constant/id.constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize(oneSignalID);
  print(oneSignalID);
  OneSignal.Notifications.requestPermission(true);

  await Future.delayed(Duration(seconds: 5));
  var test = OneSignal.User.pushSubscription;
  print('result==>');

  print(jsonEncode(test.toString()));

  runApp(const ShrineApp());
}
 