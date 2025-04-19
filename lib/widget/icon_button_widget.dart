import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
    required this.onTap,
    this.backColor = Colors.white,
    this.iconColor = Colors.black,
    this.isIcon = true,
    this.btnText = '',
  });

  final IconData icon;
  final double height;
  final double width;
  final Function()? onTap;
  final Color backColor;
  final Color iconColor;
  final bool isIcon;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child:
            isIcon
                ? Icon(icon, color: iconColor)
                : Center(
                  child: Text(
                    btnText,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
      ),
    );
  }
}
