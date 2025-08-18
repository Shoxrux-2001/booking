import 'package:flutter/material.dart';
import 'package:restaurant/features/home/models/food_model.dart';
import 'package:restaurant/features/home/repo/food_rpo.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodRepository _repository;
  bool _isLoading = false;
  String? _error;
  List<FoodModel> _foods = [];

  FoodViewModel(this._repository);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<FoodModel> get foods => _foods;

  Future<void> fetchFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _foods = await _repository.fetchFoods();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}