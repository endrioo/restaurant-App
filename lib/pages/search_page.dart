import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/data/models/restaurant_search_model.dart';
import 'package:restaurant_app_submission1/pages/detail_page.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';
import 'package:restaurant_app_submission1/widget/build_restaurant_list.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search";

  const SearchPage({Key? key}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  late RestaurantProvider restaurantProvider;
  final TextEditingController _controller = TextEditingController();
  String search = " ";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 25,
                right: 5,
                top: 2,
                bottom: 2,
              ),
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller,
                cursorColor: secondaryColor,
                style: const TextStyle(
                  color: secondaryColor,
                  decoration: TextDecoration.none,
                ),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      "assets/svg/bx-search.svg",
                      color: secondaryColor,
                    ),
                    onPressed: () {},
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    if (_controller.text == "") {
                      search = " ";
                    } else {
                      search = _controller.text;
                    }
                    restaurantProvider.fetchSearchResult(search);
                  });
                },
              ),
            ),
            ChangeNotifierProvider<RestaurantProvider>(
              create: (_) {
                restaurantProvider =
                    RestaurantProvider(apiService: ApiService());
                return restaurantProvider.fetchSearchResult(search);
              },
              child: ItemSearchResult(
                search: search,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ItemSearchResult extends StatelessWidget {
  final String search;
  const ItemSearchResult({
    Key? key,
    required this.search,
  }) : super(key: key);

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
          return Column(
            children: [
              Text(
                search == " "
                    ? "Search Restaurant"
                    : "founded ${state.searchRestaurant!.founded} Restaurant",
                style: const TextStyle(
                  color: secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              search == " "
                  ? const Text("")
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.searchRestaurant!.restaurants.length,
                      itemBuilder: (context, index) {
                        var search = state.searchRestaurant!.restaurants[index];
                        Restaurant? restaurant;
                        for (var i = 0;
                            i < state.restaurantList!.restaurants.length;
                            i++) {
                          if (state.restaurantList!.restaurants[i].id ==
                              search.id) {
                            restaurant = state.restaurantList!.restaurants[i];
                          }
                        }
                        return BuildRestaurantList(restaurant: restaurant);
                      },
                    ),
            ],
          );
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: Text(
              "Restaurant Not found",
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
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

Widget buildsearchList(BuildContext context, RestaurantSearch restaurant) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: primaryColor,
        ),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant.id);
          },
          leading: Hero(
            tag: "${ApiService.baseUrlImage}${restaurant.pictureId}",
            child: ClipRRect(
              child: Image.network(
                "${ApiService.baseUrlImage}${restaurant.pictureId}",
                width: 100,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          title: Text(
            restaurant.name,
            style: const TextStyle(
              color: whiteText,
              fontSize: 17,
            ),
          ),
          subtitle: Column(
            children: [
              Text(
                restaurant.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: whiteText,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          color: whiteText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        restaurant.city,
                        style: const TextStyle(
                          color: whiteText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
