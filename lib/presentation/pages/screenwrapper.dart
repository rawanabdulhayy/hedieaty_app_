import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/data/data_repo/list_of_nav_bar_items.dart';
import 'package:hedieaty_app_mvc/domain/navigation_controller.dart';
import 'package:hedieaty_app_mvc/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.navyBlue,
              title: Center(
                child: Text(
                  listOfNavigationBarItems[navigationController.currentIndex].title,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontFamily: "Pacifico",
                    fontSize: 27,
                  ),
                ),
              ),
              iconTheme: IconThemeData(
                color: AppColors.gold,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.card_giftcard),
                  onPressed: () {
                    // TODO Navigate to Homepage.
                  },
                ),
              ],
            ),
          body: listOfNavigationBarItems[navigationController.currentIndex].page,
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}
