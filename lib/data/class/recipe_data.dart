import 'package:forkify_app/data/class/ingredients_data.dart';

class RecipeData {
  final String id;
  final int cookingTime;
  final int servings;
  final String title;
  final String imageUrl;
  final String sourceUrl;
  final String publisher;
  final List<IngredientsData> ingredients;

  RecipeData({
    required this.id,
    required this.cookingTime,
    required this.servings,
    required this.title,
    required this.imageUrl,
    required this.sourceUrl,
    required this.publisher,
    required this.ingredients,
  });

  factory RecipeData.fromJson(Map<String, dynamic> json) {
    var ings =
        (json['ingredients'] as List)
            .map((ing) => IngredientsData.fromJson(ing))
            .toList();

    return RecipeData(
      id: json['id'],
      cookingTime: json['cooking_time'],
      servings: json['servings'],
      title: json['title'],
      imageUrl: json['image_url'],
      sourceUrl: json['source_url'],
      publisher: json['publisher'],
      ingredients: ings,
    );
  }
}
