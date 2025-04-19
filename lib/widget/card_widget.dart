import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/widget/icon_button_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.title,
    required this.publisher,
    required this.ontap,
    this.isBookmarked = false,
    required this.removeCard,
  });
  final String imageUrl;
  final String id;
  final String title;
  final String publisher;
  final bool isBookmarked;
  final GestureTapCallback? ontap;
  final GestureTapCallback? removeCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 19,
                        color: Kcolors.primaryColor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      publisher.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              isBookmarked
                  ? Row(
                    children: [
                      SizedBox(width: 10),
                      IconButtonWidget(
                        icon: Icons.delete,
                        iconColor: Kcolors.primaryColor,
                        height: 45,
                        width: 45,
                        onTap: removeCard,
                      ),
                    ],
                  )
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
