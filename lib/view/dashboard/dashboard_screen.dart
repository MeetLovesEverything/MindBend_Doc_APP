import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_bend_doc/view/Budget/budget.dart';

import '../../controller/controllers.dart';
import '../home/home.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: IndexedStack(
            index: dashboardController.currentIndex.value,
            children: const [
              HomeScreen(),
              BudgetScreen(),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.grey.shade100,
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.note_add_outlined, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            dashboardController.updateIndex(index);
          },
          index: dashboardController.currentIndex.value,
        ),
      );
    });
  }
}
