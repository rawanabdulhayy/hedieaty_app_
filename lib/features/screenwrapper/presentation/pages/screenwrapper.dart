import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/list_of_nav_bar_items.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/presentation/widgets/app_bar/custom_app_bar.dart';



class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navigationController, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title:  listOfNavigationBarItems[navigationController.currentIndex].title,
            actions: [
                IconButton(
                  icon: Icon(Icons.card_giftcard),
                  onPressed: () {
                    Navigator.pushNamed(context, '/opening_page'); // Replace with the actual route name of your homepage
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
