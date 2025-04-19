import 'package:flutter/material.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/data/providers/recipe_data_provider.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/view/widget_tree.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Hive ----------------------------------- >
  await Hive.initFlutter();
  // Ouverture de Box (une sorte de base de données locale) ---- >
  await Hive.openBox("favoris");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeDataProvider()),
        ChangeNotifierProvider(create: (context) => ModelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(243, 142, 130, 1),
          primary: Kcolors.primaryColor,
          secondary: Kcolors.secondaryColor,
          tertiary: Kcolors.tertiaryColor,
          brightness: Brightness.light,
        ),
      ),
      home: WidgetTree(),
    );
  }
}
