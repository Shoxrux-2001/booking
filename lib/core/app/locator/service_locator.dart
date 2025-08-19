import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant/features/home/data/repository/restaurant_repository_impl.dart';
import 'package:restaurant/features/home/data/source/restaurant_remote_datasource.dart';
import 'package:restaurant/features/home/domain/usecases/get_restaurants.dart';
import 'package:restaurant/features/home/presentation/bloc/restaurant_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Remote DataSource
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton(() => RestaurantRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetRestaurants(sl()));

  // Bloc
  sl.registerFactory(() => RestaurantBloc(sl()));

  // Dastlabki restoranlarni qo'shish
  await sl<RestaurantRemoteDataSource>().initRestaurants();
}
