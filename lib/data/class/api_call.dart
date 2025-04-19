import 'dart:convert';
import 'package:forkify_app/data/class/recipe_data.dart';
import 'package:forkify_app/data/class/recipe_response.dart';
import 'package:forkify_app/data/class/search_result.dart';
import 'package:forkify_app/data/constants.dart';

import 'package:http/http.dart' as http;

class ApiCalls {
  // FETCHING DATA FOR A SINGLE RECIPE
  Future<RecipeData> loadRecipe(String id) async {
    var resultCall = await http.get(Uri.parse('${MyData.urlApi}/$id'));

    if (resultCall.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(resultCall.body);
      RecipeData recipe = RecipeResponse.fromJson(jsonData).recipe;

      return recipe;
    } else {
      throw Exception('Failed to load DATA');
    }
  }

  Future<SearchResult> loadSearch(String querry) async {
    var resultCall = await http.get(
      Uri.parse('${MyData.urlApi}?search=$querry'),
    );

    if (resultCall.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(resultCall.body);
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      return SearchResult.fromJson(jsonData);
    } else {
      throw Exception('Failed to load');
    }
  }
}
