import 'package:flutter/material.dart';

class Kcolors {
  static Color primaryColor = Color.fromRGBO(243, 142, 130, 1);
  static Color secondaryColor = Color.fromRGBO(251, 219, 137, 1);
  static Color tertiaryColor = Color.fromRGBO(244, 137, 130, 1);

  static Color greyLight1 = Color.fromRGBO(249, 245, 243, 1);

  //   $color-grey-light-1: #f9f5f3; // Light background
  // $color-grey-light-2: #f2efee; // Light lines
  // $color-grey-light-3: #d3c7c3; // Light text (placeholder)
  // $color-grey-dark-1: #615551; // Normal text
  // $color-grey-dark-2: #918581;

  static Gradient gradientBg = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
    colors: [Kcolors.secondaryColor, Kcolors.tertiaryColor],
  );

  static OutlineInputBorder inputBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(100),
  );
}

class MyData {
  static int ELEMENT_PER_PAGES = 5;
  static String API_KEY = '50f69d8b-4ea8-4a47-987d-addd29f87d42';
  static const String urlApi =
      'https://forkify-api.herokuapp.com/api/v2/recipes';
}
