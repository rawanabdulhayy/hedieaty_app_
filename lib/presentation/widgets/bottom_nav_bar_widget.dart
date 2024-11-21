import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/data/list_of_nav_bar_items.dart';
import 'package:hedieaty_app_mvc/domain/navigation_controller.dart';
import 'package:provider/provider.dart';

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
          //Step 2: Creating the list of pages to show.
          items: [
            //Using the already built in nav bar item in items
            ...listOfNavigationBarItems.map((item) => BottomNavigationBarItem(label: item.title, icon: Icon(item.icon)))
          ],
          //currentIndex: my own custom? Step 5: Controller for controlling the cuurentindex
          currentIndex :navigationController.currentIndex,

          onTap: (index) {
            navigationController.updateIndex(index);
          },

        );
      },
    );
  }
}
