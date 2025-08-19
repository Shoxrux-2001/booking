import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/features/home/data/models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getAllRestaurants();
  Future<void> initRestaurants(); // Dastlabki restoranlarni qo'shish
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final FirebaseFirestore firestore;

  RestaurantRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<RestaurantModel>> getAllRestaurants() async {
    try {
      final snapshot = await firestore.collection('restaurants').get();
      return snapshot.docs
          .map((doc) => RestaurantModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Error fetching restaurants: $e");
    }
  }

  @override
  Future<void> initRestaurants() async {
    final collection = firestore.collection('restaurants');

    final snapshot = await collection.get();
    if (snapshot.docs.isEmpty) {
      final restaurants = [
        {
          'name': 'Tashkent Delight',
          'imageUrl': 'https://example.com/image1.jpg',
          'lat': 41.2995,
          'lng': 69.2401,
          'category': 'Uzbek Cuisine',
          'rating': 4.5,
        },
        {
          'name': 'Samarkand Sweets',
          'imageUrl': 'https://example.com/image2.jpg',
          'lat': 39.6542,
          'lng': 66.9597,
          'category': 'Desserts',
          'rating': 4.7,
        },
        {
          'name': 'Bukhara Feast',
          'imageUrl': 'https://example.com/image3.jpg',
          'lat': 39.7671,
          'lng': 64.4233,
          'category': 'Uzbek Cuisine',
          'rating': 4.6,
        },
        {
          'name': 'Fergana Grill',
          'imageUrl': 'https://example.com/image4.jpg',
          'lat': 40.3893,
          'lng': 71.7840,
          'category': 'Barbecue',
          'rating': 4.4,
        },
        {
          'name': 'Khiva Corner',
          'imageUrl': 'https://example.com/image5.jpg',
          'lat': 41.3782,
          'lng': 60.3600,
          'category': 'Uzbek Cuisine',
          'rating': 4.3,
        },
        {
          'name': 'Andijan Bistro',
          'imageUrl': 'https://example.com/image6.jpg',
          'lat': 40.7826,
          'lng': 72.3441,
          'category': 'Fast Food',
          'rating': 4.2,
        },
        {
          'name': 'Nukus Noodles',
          'imageUrl': 'https://example.com/image7.jpg',
          'lat': 42.4667,
          'lng': 59.6167,
          'category': 'Asian Cuisine',
          'rating': 4.5,
        },
        {
          'name': 'Namangan Diner',
          'imageUrl': 'https://example.com/image8.jpg',
          'lat': 41.0000,
          'lng': 71.6667,
          'category': 'Uzbek Cuisine',
          'rating': 4.4,
        },
      ];

      for (var restaurant in restaurants) {
        await collection.add(restaurant);
      }
    }
  }
}
