import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';

class AddReview extends StatefulWidget {
  static const routeName = "/addReview";
  const AddReview({
    Key? key,
    required this.restautantId,
  }) : super(key: key);

  final String restautantId;

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  late RestaurantProvider restaurantProvider;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: const Text('Add Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ChangeNotifierProvider<RestaurantProvider>(
                create: (_) {
                  restaurantProvider =
                      RestaurantProvider(apiService: ApiService());
                  return restaurantProvider
                      .fetchDetailRestaurant(widget.restautantId);
                },
                child: reviewRestaurant(context),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Add Review",
                style: TextStyle(
                  color: whiteText,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Name",
                  style: TextStyle(
                    color: whiteText,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Review",
                  style: TextStyle(
                    color: whiteText,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  controller: _reviewController,
                  cursorColor: secondaryColor,
                  style: const TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.none,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Review",
                    hintStyle: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text == "" || _reviewController.text == "") {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: primaryColor,
                          duration: Duration(seconds: 1),
                          content: Text(
                            "Add Review and Name First",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    });
                  } else {
                    setState(() {
                      String id = widget.restautantId;
                      String name = _controller.text;
                      String review = _reviewController.text;
                      ApiService().createReview(id, name, review);
                      _controller.text = "";
                      _reviewController.text = "";
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: primaryColor,
                          duration: Duration(seconds: 1),
                          content: Text(
                            "Review Added",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    });
                  }
                },
                child: const Text("Send Review"),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  onPrimary: whiteText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _reviewController.dispose();
  }
}

Widget reviewRestaurant(BuildContext context) {
  return Consumer<RestaurantProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        );
      } else if (state.state == ResultState.hasData) {
        final restaurant = state.restaurantDetail!.restaurantDetail;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: primaryColor,
            ),
            child: ListTile(
              leading: ClipRRect(
                child: Image.network(
                  "${ApiService.baseUrlImage}${restaurant.pictureId}",
                  width: 100,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
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
