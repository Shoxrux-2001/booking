import 'package:restaurant/gen/assets.gen.dart';

class FoodModel {
  final String name;
  final String image;
  final String location;
  final double? latitude;
  final double? longitude;

  FoodModel({
    required this.name,
    required this.image,
    required this.location,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Masalan, test uchun statik ma'lumotlar
  static List<FoodModel> get sampleData => [
    FoodModel(
      name: 'Biryani',
      image: Assets.images.biryani,
      location: 'Agrabad 435, Chittagong',
      latitude: 22.3569,
      longitude: 91.7832,
    ),
    FoodModel(
      name: 'Fast Food',
      image: Assets.images.fastfood,
      location: 'Chawkbazar, Chittagong',
      latitude: 22.3500,
      longitude: 91.8000,
    ),
    FoodModel(
      name: 'Hotel',
      image: Assets.images.hotel,
      location: 'Nasirabad, Chittagong',
      latitude: 22.3700,
      longitude: 91.8100,
    ),
  ];
}