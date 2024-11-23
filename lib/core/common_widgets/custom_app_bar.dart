import 'package:flutter/material.dart';
import '../app_colors.dart';

// Custom AppBar Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  CustomAppBar({
    required this.title,
    this.actions, this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navyBlue,
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.gold,
            fontFamily: "Pacifico",
            fontSize: 27,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.gold,
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  // Define a custom height for the AppBar, considering the TabBar's height
  @override
  Size get preferredSize {
    // If a bottom widget like TabBar is present, add its height to the AppBar height
    double bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
