import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:fraction/fraction.dart';

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({
    super.key,
    required this.quantity,
    required this.descText,
    required this.unit,
  });
  final double? quantity;
  final String unit;
  final String descText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.verified, size: 25, color: Kcolors.primaryColor),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                (quantity == null)
                    ? descText
                    : '${Fraction.fromDouble(quantity!)} $unit $descText',
                style: TextStyle(color: Colors.blueGrey, fontSize: 17),
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
