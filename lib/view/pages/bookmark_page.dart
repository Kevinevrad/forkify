import 'package:flutter/material.dart';
import 'package:forkify_app/data/providers/model_provider.dart';
import 'package:forkify_app/widget/card_widget.dart';
import 'package:forkify_app/widget/message_widget.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final modelprovider = Provider.of<ModelProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Bookmarks'.toUpperCase(),
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
        ),

        SizedBox(height: 10),

        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment:
                  modelprovider.bookmarkArray.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
              children: [
                if (modelprovider.bookmarkArray.isEmpty) ...[
                  MessageWidget(
                    message: 'Go Booked some recipes...',
                    icon: Icons.emoji_emotions,
                  ),
                ],

                if (modelprovider.bookmarkArray.isNotEmpty) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: modelprovider.bookmarkArray.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                          isBookmarked: true,
                          imageUrl:
                              // bookmarkSave.value[index]['imageUrl'],
                              modelprovider.bookmarkArray[index]['imageUrl'],
                          id:
                              // bookmarkSave.value[index]['id'],
                              modelprovider.bookmarkArray[index]['id'],
                          title:
                              // bookmarkSave.value[index]['title'],
                              modelprovider.bookmarkArray[index]['title'],
                          publisher:
                              // bookmarkSave.value[index]['publisher'],
                              modelprovider.bookmarkArray[index]['publisher'],
                          ontap: () {
                            modelprovider.loadModelRecipe(
                              modelprovider.bookmarkArray[index]['id'],
                              // bookmarkSave.value[index]['id'],
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => RecipePage(id: ,),
                            //   ),
                            // );
                          },
                          removeCard: () {
                            modelprovider.removeRecipeFromBook(
                              modelprovider.bookmarkArray[index]['id'],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
