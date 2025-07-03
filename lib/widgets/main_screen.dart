import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../pages/home/home_page.dart';
import '../pages/reservation/reservation_list_page.dart';
import '../pages/community/post_list_page.dart';
import '../pages/my/my_page.dart';
import 'bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: _getScreen(navigationController.selectedIndex.value),
          )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomePage(key: ValueKey('home'));
      case 1:
        return const ReservationListPage(key: ValueKey('reservation'));
      case 2:
        return const PostListPage(key: ValueKey('community'));
      case 3:
        return const MyPage(key: ValueKey('my'));
      default:
        return const HomePage(key: ValueKey('home'));
    }
  }
}
