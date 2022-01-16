import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/pages/restaurant_list.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool buttonActive = true;
  RestaurantProvider? restaurantProvider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fast And\nDelicious Food",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: whiteText,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      'Restaurant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteText,
                        fontSize: 15,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: buttonActive ? buttonColor : Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      buttonActive =
                          buttonActive ? buttonActive : !buttonActive;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      'Take Away',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteText,
                        fontSize: 15,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: buttonActive ? Colors.transparent : buttonColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      buttonActive =
                          buttonActive ? !buttonActive : buttonActive;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pick Your Food / Restaurant",
                style: TextStyle(
                  color: whiteText,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            buttonActive
                ? ChangeNotifierProvider<RestaurantProvider>.value(
                    value: RestaurantProvider(apiService: ApiService())
                        .fetchAllRestaurant(),
                    child: const RestaurantListView(),
                  )
                : Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Take Away Not Available",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
