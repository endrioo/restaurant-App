import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_submission1/data/api/api_service.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app_submission1/data/models/restaurant_search_model.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({
    required this.apiService,
  }) {
    fetchAllRestaurant();
  }

  RestaurantList? _restaurantList;
  RestaurantDetails? _restaurantDetail;
  SearchRestaurantList? _searchRestaurant;
  ResultState? _state;
  ResultState? _detailState;
  String _massage = "";

  String? get massage => _massage;
  RestaurantList? get restaurantList => _restaurantList;
  RestaurantDetails? get restaurantDetail => _restaurantDetail;
  SearchRestaurantList? get searchRestaurant => _searchRestaurant;
  ResultState? get state => _state;
  ResultState? get detailState => _detailState;

  RestaurantProvider fetchAllRestaurant() {
    _fetchAllRestaurant();
    return this;
  }

  RestaurantProvider fetchDetailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }

  RestaurantProvider fetchSearchResult(String query) {
    _fetchSearchResult(query);
    return this;
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _massage = "Empty Data :(";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _massage = "Error ---> $e";
    }
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _detailState = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().getDetailRestaurant(id);
      if (restaurant.message == "restaurant not found") {
        _detailState = ResultState.noData;
        notifyListeners();
        return _massage = "Empty Data :(";
      } else {
        _detailState = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _detailState = ResultState.error;
      notifyListeners();
      return _massage = "Error ---> $e";
    }
  }

  Future<dynamic> _fetchSearchResult(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _massage = "Empty Data :(";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _massage = "Error ---> $e";
    }
  }
}
