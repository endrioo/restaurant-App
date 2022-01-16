import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';
import 'package:restaurant_app_submission1/helper/database_helper.dart';
import 'package:restaurant_app_submission1/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    getFavoriteList();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _massage = "";
  String get massage => _massage;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void getFavoriteList() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _massage = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      getFavoriteList();
    } catch (e) {
      _state = ResultState.error;
      _massage = 'Error';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavoriteList();
    } catch (e) {
      _state = ResultState.error;
      _massage = 'Error';
      notifyListeners();
    }
  }
}
