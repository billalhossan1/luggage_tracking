import 'package:flutter/material.dart';
import 'package:luggage_tracking/const/assets_icons_path.dart';
import 'package:luggage_tracking/widgets/app_image/app_image.dart';
import 'package:luggage_tracking/widgets/appbar/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a CustomScrollView to enable slivers
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with some basic properties
          SliverAppBar(
            pinned: true, // height when expanded
            flexibleSpace: CustomAppBar(
              leading: AppImage(
                path: AssetsIconsPath.instance.,
              ),
            ),
          ),

          // SliverList to display a list of items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Item #$index'),
              ),
              childCount: 30, // number of list items
            ),
          ),
        ],
      ),
    );
  }
}
