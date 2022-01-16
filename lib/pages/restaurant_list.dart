import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';
import 'package:restaurant_app_submission1/widget/build_restaurant_list.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: state.restaurantList!.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.restaurantList!.restaurants[index];
              return BuildRestaurantList(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.massage!));
        } else if (state.state == ResultState.error) {
          return const Center(
            child: Text(
              "No Internet",
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const Text("");
        }
      },
    );
  }
}
