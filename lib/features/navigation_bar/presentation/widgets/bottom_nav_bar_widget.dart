import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/list_of_nav_bar_items.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

// Step 1: Creating the bottom nav bar widget to hold the UI that shows.
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
//       How Does It Work?
// The ChangeNotifierProvider provides a ChangeNotifier to the widget tree.
// The Consumer listens to that ChangeNotifier and gets notified of updates.
// The builder in the Consumer updates the specific UI components based on the provider's new state.
      builder: (context, navigationController, child) {
        //In the builder function of a Consumer, the second parameter (navigationController in your example) is automatically an instance of the provider class you specify in the Consumer's generic type (NavigationController in this case). The name you give to this parameter (navigationController) can be any valid variable name, and it doesn't have to match the class name.
        //Using the already built in nav bar
        return BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.gold,  // Color when the item is selected
          unselectedItemColor: AppColors.brightBlue,  // Color when the item is unselected
          backgroundColor: AppColors.navyBlue,  // Background color of the Bottom Navigation Bar
          //Step 2: Creating the list of pages to show.
          items: [
            ...listOfNavigationBarItems.map((item) {
              return BottomNavigationBarItem(
                label: item.title,
                icon: Icon(
                  item.icon,
                  color: navigationController.currentIndex == listOfNavigationBarItems.indexOf(item)
                      ? AppColors.gold  // Icon color when selected
                      : AppColors.brightBlue,  // Icon color when unselected
                ),
              );
            }).toList(),
          ],
          //currentIndex: my own custom? Step 5: Controller for controlling the currentIndex
          currentIndex :navigationController.currentIndex,
          onTap: (index) {
            navigationController.navigateToPage(index);
          },

        );
      },
    );
  }
}
