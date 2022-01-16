import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app_submission1/data/models/restaurant_search_model.dart';
import 'package:restaurant_app_submission1/data/models/review_model.dart';

class ApiService {
  static const baseUrl = "https://restaurant-api.dicoding.dev/";
  static const baseUrlImage = "${baseUrl}images/large/";

  Future<RestaurantList> getListRestaurant() async {
    final response = await http.get(Uri.parse(baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed To Load Restaurant List :(");
    }
  }

  Future<RestaurantDetails> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed To Load Restaurant Detail :(");
    }
  }

  Future<SearchRestaurantList> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed To Load Restaurant Search Result :(");
    }
  }

  Future<ReviewModel> createReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse("https://restaurant-api.dicoding.dev/review"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          "id": id,
          "name": name,
          "review": review,
        },
      ),
    );

    if (response.statusCode == 201) {
      return ReviewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed To Create Review :(');
    }
  }
}
