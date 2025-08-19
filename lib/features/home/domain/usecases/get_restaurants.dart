

import 'package:restaurant/features/home/domain/entities/restaurant_entity.dart';
import 'package:restaurant/features/home/domain/repository/restaurant_repository.dart';

class GetRestaurants {
  final RestaurantRepository repository;

  GetRestaurants(this.repository);

  Future<List<RestaurantEntity>> call() async {
    return await repository.getAllRestaurants();
  }
}
