import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';

class RecipeSectionTitle extends StatelessWidget {
  const RecipeSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 22,
            color: Kcolors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
