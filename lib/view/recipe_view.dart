import 'package:flutter/material.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/widget/cooking_infos.dart';
import 'package:forkify_app/widget/icon_button_widget.dart';
import 'package:forkify_app/widget/message_widget.dart';
import 'package:forkify_app/widget/recipe_section_title.dart';
import 'package:fraction/fraction.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  // SAVE DATA LOCALLY -------------------------------->

  bool isSaved(Map<String, dynamic> recipe) {
    final box = Hive.box('favoris');
    List prefs = box.get('recipeList', defaultValue: []);
    return prefs.any((rep) => rep['id'] == recipe['id']);
  }

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);

    return (modelProvider.isLoading)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator.adaptive()],
        )
        : modelProvider.errorMessage.isNotEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageWidget(
              message: modelProvider.errorMessage,
              icon: Icons.dangerous,
            ),
          ],
        )
        : Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        modelProvider.currentRecipe!['imageUrl'],
                      ),
                    ),
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ----------------------------------------
                            // ARROW BACK BUTTON ----------------------
                            // ----------------------------------------
                            Expanded(
                              child: IconButtonWidget(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                height: 40,
                                width: 40,
                                icon: Icons.arrow_back_ios_new_outlined,
                                // iconColor: Kcolors.primaryColor,s
                              ),
                            ),
                            SizedBox(width: 10),

                            // ----------------------------------------
                            // RECIPE INGREDIENTS ------------------------
                            // ----------------------------------------
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  modelProvider.currentRecipe!['title']
                                      .toUpperCase(),
                                  style: TextStyle(
                                    // color: Kcolors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),

                            // ----------------------------------------
                            // BOOKMARK BUTTON ------------------------
                            // ----------------------------------------
                            Expanded(
                              child: IconButtonWidget(
                                onTap: () {
                                  setState(() {
                                    modelProvider.saveRecipe(
                                      modelProvider.currentRecipe!,
                                    );
                                  });
                                },
                                height: 40,
                                width: 40,
                                // iconColor: Kcolors.primaryColor,
                                icon:
                                    isSaved(modelProvider.currentRecipe!)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // -----------------------------------------------------------------
                // ------ BUTTONS INCREASE SERVINS AND OTHERS ----------------------
                // -----------------------------------------------------------------
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Kcolors.greyLight1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        // -----------------------------------------------------------------
                        // ------ COOKING TIME INFOS ---------------------------------------
                        // -----------------------------------------------------------------
                        CookingInfos(
                          infoCookingValue:
                              '${modelProvider.currentRecipe!['cookingTime']}',
                          infoIcon: Icons.timer,
                          infoMessage: 'minutes',
                        ),
                        SizedBox(width: 13),

                        // -----------------------------------------------------------------
                        // ------ SERVING INFOS --------------------------------------------
                        // -----------------------------------------------------------------
                        CookingInfos(
                          infoIcon: Icons.person_2,
                          infoMessage: 'servings',
                          infoCookingValue:
                              '${modelProvider.currentRecipe!['servings']}',
                        ),
                        SizedBox(width: 40),

                        // -----------------------------------------------------------------
                        // ------ ICONS INCREASE AND DECREASE SERVINGS ---------------------
                        // -----------------------------------------------------------------
                        Row(
                          children: [
                            IconButtonWidget(
                              icon: Icons.add_circle,
                              iconColor: Colors.white,
                              height: 47,
                              width: 45,
                              backColor: Kcolors.primaryColor,
                              onTap: () {
                                if (modelProvider.currentRecipe!['servings'] >=
                                    1) {
                                  var count =
                                      modelProvider
                                          .currentRecipe!['servings']++;
                                  modelProvider.updateServings(count);
                                }
                              },
                            ),
                            SizedBox(width: 5),
                            IconButtonWidget(
                              icon: Icons.remove_circle,
                              iconColor: Colors.white,
                              height: 47,
                              width: 45,
                              backColor: Kcolors.primaryColor,
                              onTap: () {
                                if (modelProvider.currentRecipe!['servings'] >=
                                    1) {
                                  var count =
                                      modelProvider
                                          .currentRecipe!['servings']--;
                                  modelProvider.updateServings(count);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // -------------------------------------------
                // RECIPE INGREDIENTS BLOC -------------------
                // -------------------------------------------
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      // -------------------------------------------
                      // RECIPE INGREDIENTS TITLE ------------------------
                      // -------------------------------------------
                      RecipeSectionTitle(title: 'recipe Ingredients'),

                      // -------------------------------------------
                      // RECIPE INGREDIENTS LIST -------------------
                      // -------------------------------------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ...List.generate(
                              modelProvider
                                  .currentRecipe!['ingredients']
                                  .length,
                              (index) {
                                final ingredients =
                                    modelProvider
                                        .currentRecipe!['ingredients'][index];

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.verified_outlined,
                                          size: 30,
                                          color: Kcolors.primaryColor,
                                        ),

                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            '${(ingredients['quantity'] == null) ? '' : Fraction.fromDouble(ingredients['quantity'])} ${ingredients['unit']}  ${ingredients['descText']}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),

                // -------------------------------------------
                // RECIPE  PUBLISHER -------------------
                // -------------------------------------------
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      RecipeSectionTitle(title: "how to cook it"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,

                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'This recipe was carefully designed and tested by ',
                                children: [
                                  TextSpan(
                                    text:
                                        '${modelProvider.currentRecipe!['publisher']}. '
                                            .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Please check out directions at their website.',
                                  ),
                                ],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      IconButtonWidget(
                        isIcon: false,
                        btnText: 'DIRECTION',
                        icon: Icons.forward,
                        height: 45,
                        width: 150,
                        backColor: Kcolors.primaryColor,
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
