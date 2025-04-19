import 'package:flutter/material.dart';

import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/view/recipe_view.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolors.greyLight1,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Kcolors.greyLight1,
          child: Center(child: RecipeView()),
        ),
      ),
    );
  }
}
