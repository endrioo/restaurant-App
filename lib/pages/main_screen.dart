import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/helper/database_helper.dart';
import 'package:restaurant_app_submission1/helper/notification_helper.dart';
import 'package:restaurant_app_submission1/pages/detail_page.dart';
import 'package:restaurant_app_submission1/pages/favorite_page.dart';
import 'package:restaurant_app_submission1/pages/home_page.dart';
import 'package:restaurant_app_submission1/pages/search_page.dart';
import 'package:restaurant_app_submission1/pages/user_page.dart';
import 'package:restaurant_app_submission1/provider/database_provider.dart';

final NotificationHelper _notificationHelper = NotificationHelper();

int currentIndex = 0;

class HomeScreen extends StatefulWidget {
  static const routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool buttonActive = true;

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
    DatabaseProvider(databaseHelper: DatabaseHelper()).getFavoriteList();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    selectedNotificationSubject.close();
  }

  final tabs = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Restaurant'),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, "/notification");
            },
          )
        ],
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        backgroundColor: primaryColor,
        selectedItemColor: buttonColor,
        unselectedItemColor: whiteText,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                "assets/svg/bx-home.svg",
                color: currentIndex == 0 ? buttonColor : whiteText,
              ),
            ),
            label: "_",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/bx-search.svg",
              color: currentIndex == 1 ? buttonColor : whiteText,
            ),
            label: "_",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/bx-heart.svg",
              color: currentIndex == 2 ? buttonColor : whiteText,
            ),
            label: "_",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/bx-user.svg",
              color: currentIndex == 3 ? buttonColor : whiteText,
            ),
            label: "_",
            backgroundColor: primaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
