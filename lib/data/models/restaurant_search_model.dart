// To parse this JSON data, do
//
//     final searchRestaurant = searchRestaurantFromJson(jsonString);

import 'dart:convert';

SearchRestaurantList searchRestaurantFromJson(String str) =>
    SearchRestaurantList.fromJson(json.decode(str));

String searchRestaurantToJson(SearchRestaurantList data) =>
    json.encode(data.toJson());

class SearchRestaurantList {
  SearchRestaurantList({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<RestaurantSearch> restaurants;

  factory SearchRestaurantList.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantList(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantSearch>.from(
            json["restaurants"].map((x) => RestaurantSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantSearch {
  RestaurantSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
