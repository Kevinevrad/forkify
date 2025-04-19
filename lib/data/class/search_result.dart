import 'package:forkify_app/data/class/search_recipe_data.dart';

class SearchResult {
  final int results;
  final List<SearchRecipeData> recipes;

  SearchResult({required this.results, required this.recipes});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    var recipesData =
        (json['data']['recipes'] as List)
            .map((rec) => SearchRecipeData.fromJson(rec))
            .toList();
    return SearchResult(results: json['results'], recipes: recipesData);
  }
}
