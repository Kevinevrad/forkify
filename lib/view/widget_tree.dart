import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';
import 'package:forkify_app/data/data_notifier.dart';
import 'package:forkify_app/view/pages/add_recipe_page.dart';
import 'package:forkify_app/view/pages/bookmark_page.dart';
import 'package:forkify_app/view/pages/home_page.dart';
import 'package:forkify_app/widget/appbar_widget.dart';
import 'package:forkify_app/widget/navnar_widget.dart';

List<Widget> pages = [HomePage(), AddRecipePage(), BookmarkPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppbarWidget(),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(gradient: Kcolors.gradientBg),
          child: ValueListenableBuilder(
            valueListenable: selectedPageNotifier,
            builder: (context, selectedPage, child) {
              return pages.elementAt(selectedPage);
            },
          ),
        ),
      ),
      bottomNavigationBar: NavnarWidget(),
    );
  }
}
