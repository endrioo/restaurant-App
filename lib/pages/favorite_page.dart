import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/provider/database_provider.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';
import 'package:restaurant_app_submission1/widget/build_restaurant_list.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite";
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Favorite Restaurant",
                    style: TextStyle(
                      color: whiteText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: provider.favorite.length,
                    itemBuilder: (context, index) {
                      return BuildRestaurantList(
                          restaurant: provider.favorite[index]);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Your Favorite \n is Empty",
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
