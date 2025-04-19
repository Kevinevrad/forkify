import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forkify_app/data/class/api_call.dart';
import 'package:forkify_app/data/class/recipe_data.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:http/http.dart' as http;

class ModelProvider with ChangeNotifier {
  ApiCalls call = ApiCalls();

  bool _isLoading = false;
  String _errorMessage = '';

  Map<String, dynamic>? _currentRecipe;
  final List<Map<String, dynamic>> _bookmarks = [];

  // ignore: prefer_final_fields
  Map<String, dynamic> _search = {
    // prettier-ignore
    "results": 0,
    "querry": "",
    "page": 1,
    'RESULT_PER_PAGE': 5,
    "recipes": [],
    "recipesPerPages": [],
    "numPages": 0,
  };

  // GETTERS -------------------------------------------------
  Map<String, dynamic>? get currentRecipe => _currentRecipe;
  Map<String, dynamic>? get search => _search;
  List<Map<String, dynamic>> get bookmarkArray => _bookmarks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // FEATCHING RECIPE DATA BY THE ID PROVIDE ------------------------
  Future<void> loadModelRecipe(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      var recipe = await call.loadRecipe(id);
      // STORE DATA IN MY CLASS MODEL ---------------------------------

      _currentRecipe = formatRecipe(recipe);
      await Future.delayed(Duration(seconds: 2));
      if (_bookmarks.any((recipe) => recipe['id'] == id)) {
        _currentRecipe!['isBookmarked'] = true;
      } else {
        _currentRecipe!['isBookmarked'] = false;
      }
    } catch (e) {
      debugPrint("Error : $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // FETCHING ARRAYS OF RECIPE BASE ON QUERRY ---------------------
  Future<void> loadSearchResult(String querry) async {
    _isLoading = true;
    _errorMessage = '';

    notifyListeners();

    try {
      var searchRes = await call.loadSearch(querry);

      _search['results'] = searchRes.results;
      _search['querry'] = querry;
      _search['recipes'] =
          searchRes.recipes
              .map(
                (recipe) => {
                  'imageUrl': recipe.imageUrl,
                  'id': recipe.id,
                  'title': recipe.title,
                  'publisher': recipe.publisher,
                },
              )
              .toList();

      _search['recipesPerPages'] = _search['recipes'].getRange(0, 5).toList();
      // savePrefBoomarks();
    } catch (e) {
      _errorMessage = 'Error Failed to load DATA : $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // FORMATING THE RECIEVED DATA -----------------------
  Map<String, dynamic> formatRecipe(RecipeData recipe) {
    return {
      'id': recipe.id,
      'servings': recipe.servings,
      'publisher': recipe.publisher,
      'cookingTime': recipe.cookingTime,
      'imageUrl': recipe.imageUrl,
      'sourceUrl': recipe.sourceUrl,
      'title': recipe.title,
      'ingredients':
          recipe.ingredients.map((el) {
            return {
              'quantity': el.quantity,
              'unit': el.unit,
              'descText': el.descText,
            };
          }).toList(),
    };
  }

  // UPDATING THE RECIPE SERVING -----------------------------------------
  void updateServings(int newServing) {
    _currentRecipe!['ingredients'].forEach((ing) {
      ing['quantity'] =
          (ing['quantity'] == null)
              ? null
              : (ing['quantity']! * newServing) / _currentRecipe!['servings'];

      //
    });

    notifyListeners();
  }

  // LOGIC FOR PERSISTENT DATA WITH HIVE ----------------------------------

  // LOGICS FOR BOOKED AND UNBOOKED  RECIPE -------------------------------
  void removeRecipeFromBook(String id) {
    var index = _bookmarks.indexWhere((recipe) => recipe['id'] == id);
    _bookmarks.removeAt(index);
    notifyListeners();
  }

  void unBoomarkRecipe(String id) {
    var index = _bookmarks.indexWhere((recipe) => recipe['id'] == id);
    _bookmarks.removeAt(index);

    if (_currentRecipe!['id'] == id) {
      _currentRecipe!['isBookmarked'] = false;
    }
    notifyListeners();
  }

  //
  //
  //
  //
  // PAGINATION ---------------------------------
  Future<void> recipeToRender({page = 1}) async {
    _isLoading = true;
    var start = (page - 1) * _search['RESULT_PER_PAGE'];
    var end = page * _search['RESULT_PER_PAGE'];

    try {
      _search['recipesPerPages'] =
          _search['recipes']
              .getRange(
                start,
                // TOUT VA BIEN SI LE MODULO DE LA TAILLE DU TABLEAU PAR 5 EST 0
                // DANS LE CAS CONTRAIRE LA FUNCTION RETOURNE UN TABLEAU DONT LA TAILLA EST != 5
                (_search['results'] % 5 == 0) ? end : _search['results'],
              )
              .toList();
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      throw Exception('Failed to load : $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  //
  //
  //  POST DATA ---------------------------
  Future<void> addRecipeRequest(
    Map<String, dynamic> recipe,
    BuildContext context,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${MyData.urlApi}?key=${MyData.API_KEY}'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(recipe),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Success! Response: ${response.body}');
        showBottomPopUp(context);
      } else {
        debugPrint('Response: ${response.body}');
        throw Exception('Error : Failed to upload recipe');
      }
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  //
  //
  // SHOW DIALOG -----------------------------------
  void showBottomPopUp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(5.0),
          height: 150,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Bottom Sheet Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("This is a modal bottom sheet."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }

  //  SAVE FAVORIS ------------------------->
}
