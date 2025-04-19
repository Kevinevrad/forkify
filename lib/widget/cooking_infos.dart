import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';

class CookingInfos extends StatelessWidget {
  const CookingInfos({
    super.key,
    required this.infoIcon,
    required this.infoMessage,
    required this.infoCookingValue,
  });

  final IconData infoIcon;
  final String infoMessage;
  final String infoCookingValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(infoIcon, size: 25),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Kcolors.primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                textAlign: TextAlign.center,
                '$infoCookingValue \n $infoMessage'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
