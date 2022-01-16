import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app_submission1/common/navigation.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:rxdart/rxdart.dart';

final selectedNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotificaitons(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSetting = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print("notification payload: " + payload);
      }
      selectedNotificationSubject.add(payload ?? 'emptyPayload');
    });
  }

  void showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantList restaurants) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDesc = "Restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iosPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    int random = Random().nextInt(restaurants.restaurants.length);
    var titleNotification = "<b>Restaurant</b>";
    var titleRestaurant = restaurants.restaurants[random].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformChannelSpecifics,
      payload: jsonEncode(
        restaurants.toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectedNotificationSubject.stream.listen((String payload) async {
      var data = RestaurantList.fromJson(jsonDecode(payload));
      int random = Random().nextInt(data.restaurants.length);
      var restaurant = data.restaurants[random];
      Navigation.intentWithData(route, restaurant);
    });
  }
}
