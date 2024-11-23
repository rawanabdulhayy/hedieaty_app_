import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/common_widgets/custom_app_bar.dart';
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
          appBar: CustomAppBar(title:  listOfNavigationBarItems[navigationController.currentIndex].title),
          body: listOfNavigationBarItems[navigationController.currentIndex].page,
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}
