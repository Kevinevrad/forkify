import 'package:forkify_app/data/class/recipe_data.dart';

class RecipeResponse {
  final RecipeData recipe;

  RecipeResponse({required this.recipe});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(recipe: RecipeData.fromJson(json['data']['recipe']));
  }
}
