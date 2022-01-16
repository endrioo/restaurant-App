import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_submission1/data/models/restaunrant_list_model.dart';

void main() {
  test('parsing restaurant model from map should return expected model', () {
    // arrange
    Map<String, dynamic> restaurantMap = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": "4.2"
    };
    //act
    final Restaurant res = Restaurant.fromJson(restaurantMap);
    // assert
    expect(res.id, "rqdv5juczeskfw1e867");
    expect(res.name, "Melting Pot");
    expect(res.description,
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...");
    expect(res.pictureId, "14");
    expect(res.city, "Medan");
    expect(res.rating, "4.2");
  });
}
