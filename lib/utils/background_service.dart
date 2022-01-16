import 'dart:isolate';

import 'dart:ui';

import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/helper/notification_helper.dart';
import 'package:restaurant_app_submission1/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = "isolate";
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callBack() async {
    print('alarm FIred!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getListRestaurant();
    _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
