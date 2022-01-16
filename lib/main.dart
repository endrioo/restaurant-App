import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/navigation.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/helper/database_helper.dart';
import 'package:restaurant_app_submission1/helper/notification_helper.dart';
import 'package:restaurant_app_submission1/helper/preferences_helper.dart';
import 'package:restaurant_app_submission1/pages/add_review.dart';
import 'package:restaurant_app_submission1/pages/detail_page.dart';
import 'package:restaurant_app_submission1/pages/main_screen.dart';
import 'package:restaurant_app_submission1/pages/settings.dart';
import 'package:restaurant_app_submission1/pages/unknow_page.dart';
import 'package:restaurant_app_submission1/provider/database_provider.dart';
import 'package:restaurant_app_submission1/provider/preferences_provider.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission1/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission1/utils/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotificaitons(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          AddReview.routeName: (context) => AddReview(
                restautantId:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const UnknowPage(),
          );
        },
      ),
    );
  }
}
