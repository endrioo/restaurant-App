import 'package:flutter/material.dart';
import 'package:restaurant_app_submission1/common/navigation.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/common/colors.dart';
import 'package:restaurant_app_submission1/pages/detail_page.dart';

class BuildRestaurantList extends StatelessWidget {
  final Restaurant? restaurant;

  const BuildRestaurantList({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            Navigation.intentWithData(
                RestaurantDetailPage.routeName, restaurant!);
          },
          leading: Hero(
            tag: "${ApiService.baseUrlImage}${restaurant!.pictureId}",
            child: ClipRRect(
              child: Image.network(
                "${ApiService.baseUrlImage}${restaurant!.pictureId}",
                width: 100,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          title: Text(
            restaurant!.name,
            style: const TextStyle(
              color: whiteText,
              fontSize: 17,
            ),
          ),
          subtitle: Column(
            children: [
              Text(
                restaurant!.description,
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
                        restaurant!.rating.toString(),
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
                        restaurant!.city,
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
  }
}
