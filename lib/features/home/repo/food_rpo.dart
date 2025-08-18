import 'package:restaurant/features/home/models/food_model.dart';

class FoodRepository {
  Future<List<FoodModel>> fetchFoods() async {
    // Test uchun statik ma'lumotlar
    return Future.delayed(
      const Duration(seconds: 1),
      () => FoodModel.sampleData,
    );
  }
}
