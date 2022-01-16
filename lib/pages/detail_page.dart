import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/pages/add_review.dart';
import 'package:restaurant_app_submission1/provider/database_provider.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/detailPage";
  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late RestaurantProvider restaurantProvider;
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(widget.restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Material(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  backgroundColor: backgroundColor,
                  elevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.red : secondaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite
                              ? provider.removeFavorite(widget.restaurant.id)
                              : provider.addFavorite(widget.restaurant);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: primaryColor,
                              duration: const Duration(seconds: 1),
                              content: Text(
                                isFavorite
                                    ? "Remove from Favorite"
                                    : 'Add to Favorite',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
                body: ChangeNotifierProvider<RestaurantProvider>(
                  create: (_) {
                    restaurantProvider =
                        RestaurantProvider(apiService: ApiService());
                    return restaurantProvider
                        .fetchDetailRestaurant(widget.restaurant.id);
                  },
                  builder: (context, _) {
                    return const RestaurantDetailView();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RestaurantDetailView extends StatefulWidget {
  const RestaurantDetailView({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  bool _buttonActive = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.detailState == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        } else if (state.detailState == ResultState.hasData) {
          final restaurant = state.restaurantDetail!.restaurantDetail;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            color: whiteText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Hero(
                          tag:
                              "${ApiService.baseUrlImage}${restaurant.pictureId}",
                          child: ClipRRect(
                            child: Image.network(
                              "${ApiService.baseUrlImage}${restaurant.pictureId}",
                              width: MediaQuery.of(context).size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: whiteText,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          restaurant.description,
                          style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              color: whiteText,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.categories.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 15),
                                child: Text(
                                  restaurant.categories[index].name,
                                  style: const TextStyle(color: whiteText),
                                ),
                              );
                            },
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
                                  'Foods',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: whiteText,
                                    fontSize: 15,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: _buttonActive
                                      ? buttonColor
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _buttonActive = _buttonActive
                                      ? _buttonActive
                                      : !_buttonActive;
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: const EdgeInsets.all(15),
                                child: const Text(
                                  'Drinks',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: whiteText,
                                    fontSize: 15,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: _buttonActive
                                      ? Colors.transparent
                                      : buttonColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _buttonActive = _buttonActive
                                      ? !_buttonActive
                                      : _buttonActive;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buttonActive
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: restaurant.menus.foods.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: primaryColor,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      restaurant.menus.foods[index].name,
                                      style: const TextStyle(color: whiteText),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: restaurant.menus.drinks.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: primaryColor,
                                    ),
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      restaurant.menus.drinks[index].name,
                                      style: const TextStyle(color: whiteText),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Customer Review',
                              style: TextStyle(
                                color: whiteText,
                              ),
                              textAlign: TextAlign.left,
                            ),
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
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.restaurantDetail!.restaurantDetail.customerReviews.length} Review',
                              style: const TextStyle(
                                color: whiteText,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AddReview.routeName,
                                    arguments: restaurant.id);
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: whiteText,
                                  ),
                                  Text(
                                    "Add Review",
                                    style: TextStyle(
                                      color: whiteText,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: restaurant.customerReviews.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        restaurant.customerReviews[index].name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: specialText,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        restaurant.customerReviews[index].date,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: specialText,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Review : \n${restaurant.customerReviews[index].review}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: whiteText,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.detailState == ResultState.noData) {
          return Center(child: Text(state.massage!));
        } else if (state.detailState == ResultState.error) {
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
