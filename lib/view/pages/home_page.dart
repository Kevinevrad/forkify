import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/view/pages/recipe_page.dart';
import 'package:forkify_app/widget/card_widget.dart';
import 'package:forkify_app/widget/message_widget.dart';
import 'package:forkify_app/widget/texfield_widget.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);

    Widget widget;

    if (modelProvider.isLoading) {
      widget = Center(child: CircularProgressIndicator.adaptive());
    } else if (modelProvider.errorMessage.isNotEmpty) {
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MessageWidget(
            message: modelProvider.errorMessage,
            icon: Icons.dangerous,
          ),
        ],
      );
    } else if (modelProvider.search!['recipes'].length == 0) {
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MessageWidget(
            icon: Icons.emoji_emotions,
            message: 'Start by making a search...',
          ),
        ],
      );
    } else {
      widget = Column(
        children: [
          Consumer<ModelProvider>(
            builder: (context, modelProvider, child) {
              modelProvider.search!['numPage'] =
                  (modelProvider.search!['results'] /
                          modelProvider.search!['RESULT_PER_PAGE'])
                      .round();
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        itemCount:
                            modelProvider.search!['recipesPerPages'].length,
                        itemBuilder: (context, index) {
                          var recipe =
                              modelProvider.search!['recipesPerPages'][index];

                          return CardWidget(
                            removeCard: () {},
                            imageUrl: recipe['imageUrl'],
                            id: recipe['id'],
                            title: recipe['title'],
                            publisher: recipe['publisher'],
                            ontap: () {
                              modelProvider.loadModelRecipe(recipe['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RecipePage();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // WE ARE ON THE LAST PAGE ----------------------------
                          if (modelProvider.search!['page'] > 1 &&
                              modelProvider.search!['numPage'] ==
                                  modelProvider.search!['page']) ...[
                            OutlinedButton.icon(
                              onPressed: () {
                                modelProvider.search!['page']--;
                                modelProvider.recipeToRender(
                                  page: modelProvider.search!['page'],
                                );
                              },
                              icon: Icon(Icons.arrow_back_outlined),
                              label: Text('Back'),
                            ),
                          ],

                          // WE ARE ON THE FIRST PAGE AND THERE ARE OTHERS PAGES ---------
                          if (modelProvider.search!['page'] == 1 &&
                              modelProvider.search!["numPage"] >
                                  modelProvider.search!['page']) ...[
                            FilledButton.icon(
                              onPressed: () {
                                modelProvider.search!['page']++;
                                modelProvider.recipeToRender(
                                  page: modelProvider.search!['page'],
                                );

                                print(modelProvider.search!['page']);
                              },
                              icon: Icon(Icons.arrow_forward_outlined),
                              label: Text('Next'),
                            ),
                          ],

                          // THERE IS ONLY ONE PAGE ----------------------------------------
                          if (modelProvider.search!['page'] == 1 &&
                              modelProvider.search!["numPage"] ==
                                  modelProvider.search!['page'])
                            ...[],

                          // WE ARE ON OTHER PAGES
                          if (modelProvider.search!['page'] > 1 &&
                              modelProvider.search!["numPage"] !=
                                  modelProvider.search!['page']) ...[
                            OutlinedButton.icon(
                              onPressed: () {
                                modelProvider.search!['page']--;
                                modelProvider.recipeToRender(
                                  page: modelProvider.search!['page'],
                                );
                              },
                              icon: Icon(Icons.arrow_back_outlined),
                              label: Text('Back'),
                            ),

                            SizedBox(width: 25),
                            FilledButton.icon(
                              onPressed: () {
                                modelProvider.search!['page']++;
                                modelProvider.recipeToRender(
                                  page: modelProvider.search!['page'],
                                );
                              },
                              icon: Icon(Icons.arrow_forward_outlined),
                              label: Text('Next'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Kcolors.greyLight1,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TexfieldWidget(
                  controller: searchController,
                  labelText: 'Search over 1,000,000 recipes ...',
                ),
              ),
              SizedBox(width: 10),
              FilledButton(
                onPressed: () {
                  modelProvider.loadSearchResult(searchController.text);
                  modelProvider.search!['page'] = 1;
                },
                child: Icon(Icons.search, size: 25),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 595,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: widget,
        ),
      ],
    );
  }
}
