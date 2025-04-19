import 'package:flutter/material.dart';
import 'package:forkify_app/data/class/api_call.dart';
import 'package:forkify_app/data/class/recipe_data.dart';

class RecipeDataProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  RecipeData? _recipe;
  final int _counter = 0;

  RecipeData? get recipe => _recipe;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get counter => _counter;

  Future<void> loadRecipeResult(String id) async {
    _isLoading = true;
    _errorMessage = '';

    notifyListeners();
    try {
      // GET THE ID ---------------------------
      ApiCalls apiCalls = ApiCalls();
      _recipe = await apiCalls.loadRecipe(id);
    } catch (e) {
      _errorMessage = 'Error Failed to load Data : $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
