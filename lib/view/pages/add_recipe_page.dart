import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/widget/texfield_widget.dart';
import 'package:provider/provider.dart';

// RECIPE CONTROLLERS -----------------------------------------

TextEditingController controllerTitle = TextEditingController(text: 'Garba');
TextEditingController controllerUrl = TextEditingController(text: 'TEST 2025');
TextEditingController controllerImageUrl = TextEditingController(
  text:
      'https://i.ytimg.com/vi/4tCqp1AgwQs/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBFa5osfWgiVQQYQh7sQPdgfkJPGg',
);
TextEditingController controllerPublisher = TextEditingController(
  text: 'TEST 2025',
);
TextEditingController controllerPrepTime = TextEditingController(text: '23');
TextEditingController controllerServings = TextEditingController(text: '23');

// INGREDIENTS CONTROLLERS -----------------------------------------

TextEditingController controllerIng1 = TextEditingController(
  text: '0.5,kg,Rice',
);
TextEditingController controllerIng2 = TextEditingController(
  text: '1,,Avocado',
);

TextEditingController controllerIng3 = TextEditingController(text: ',,salt');
TextEditingController controllerIng4 = TextEditingController();
TextEditingController controllerIng5 = TextEditingController();
TextEditingController controllerIng6 = TextEditingController();

List<TextEditingController> controllerRecipeList = [
  controllerTitle,
  controllerUrl,
  controllerImageUrl,
  controllerPublisher,
  controllerPrepTime,
  controllerServings,
];

List<TextEditingController> controllerListIng = [
  controllerIng1,
  controllerIng2,
  controllerIng3,
  controllerIng4,
  controllerIng5,
  controllerIng6,
];

List<String> labelList = [
  'Title',
  'Url',
  'ImageUrl',
  'Publisher',
  'PrepTime',
  'Servings',
];

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  void initState() {
    super.initState();
  }

  var finalArrMapIngs = [];

  Map<String, dynamic> submitFrom(List controllerList) {
    var ingredients =
        controllerList.where((element) => element.text.isNotEmpty).map((el) {
          var [quantity, unit, descText] = el.text.split(',');
          return {
            "quantity": quantity == '' ? null : double.parse(quantity),
            "unit": unit,
            "description": descText,
          };
        }).toList();

    return {
      "title": controllerTitle.text,
      "source_url": controllerUrl.text,
      "image_url": controllerImageUrl.text,
      "publisher": controllerPublisher.text,
      "cooking_time": controllerPrepTime.text,
      "servings": controllerServings.text,
      "ingredients": ingredients,
    };
  }

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Recipe Data'.toUpperCase(),
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,

            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Kcolors.greyLight1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ...List.generate(6, (index) {
                  return Column(
                    children: [
                      TexfieldWidget(
                        controller: controllerRecipeList.elementAt(index),
                        labelText: labelList.elementAt(index),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 40),
          Row(
            children: [
              Text(
                'Ingredients'.toUpperCase(),
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,

            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Kcolors.greyLight1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ...List.generate(6, (index) {
                  return Column(
                    children: [
                      TexfieldWidget(
                        controller: controllerListIng.elementAt(index),
                        labelText: "Ingredient${index + 1}",
                        hintText: "Format : 'Qauntity,Unit,Descripttion'",
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              modelProvider.addRecipeRequest(
                submitFrom(controllerListIng),
                context,
              );
            },
            label: Text('Upload'),
            icon: Icon(Icons.upload),
            style: ElevatedButton.styleFrom(
              iconSize: 30,
              textStyle: TextStyle(fontSize: 30),
            ),
            // style: ,
          ),
        ],
      ),
    );
  }
}
