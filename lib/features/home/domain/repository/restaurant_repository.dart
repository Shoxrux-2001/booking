

import 'package:restaurant/features/home/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<List<RestaurantEntity>> getAllRestaurants();
}
