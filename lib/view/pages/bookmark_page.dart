import 'package:flutter/material.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/view/pages/recipe_page.dart';
import 'package:forkify_app/widget/card_widget.dart';
import 'package:forkify_app/widget/message_widget.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final box = Hive.box('favoris');
  List recipesSaved = [];
  List loadData() {
    List recipes = box.get('recipeList') ?? [];
    return recipes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipesSaved = loadData();
  }

  @override
  Widget build(BuildContext context) {
    final modelprovider = Provider.of<ModelProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Bookmarks'.toUpperCase(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Divider(color: Colors.white, height: 1, thickness: 4),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment:
                  recipesSaved.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
              children: [
                if (recipesSaved.isEmpty) ...[
                  MessageWidget(
                    message: 'Go Booked some recipes...',
                    icon: Icons.emoji_emotions,
                  ),
                ],

                if (recipesSaved.isNotEmpty) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: recipesSaved.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                          isBookmarked: true,
                          imageUrl: recipesSaved[index]['imageUrl'],
                          id: recipesSaved[index]['id'],
                          title: recipesSaved[index]['title'],
                          publisher: recipesSaved[index]['publisher'],
                          ontap: () {
                            modelprovider.loadModelRecipe(
                              recipesSaved[index]['id'],
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipePage(),
                              ),
                            );
                          },
                          removeCard: () {
                            removeRecipeFromBook(recipesSaved[index]['id']);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void removeRecipeFromBook(String id) {
    List recipes = box.get('recipeList') ?? [];
    recipes.removeWhere((recipe) => recipe['id'] == id);
    box.put('recipeList', recipes);
    setState(() {
      recipesSaved = recipes;
    });
  }
}
