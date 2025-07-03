import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            // height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_rounded,
                  activeIcon: Icons.home_rounded,
                  label: '홈',
                  index: 0,
                  controller: navigationController,
                ),
                _buildNavItem(
                  icon: Icons.event_available_rounded,
                  activeIcon: Icons.event_available_rounded,
                  label: '예약',
                  index: 1,
                  controller: navigationController,
                ),
                _buildNavItem(
                  icon: Icons.forum_rounded,
                  activeIcon: Icons.forum_rounded,
                  label: '커뮤니티',
                  index: 2,
                  controller: navigationController,
                ),
                _buildNavItem(
                  icon: Icons.person_rounded,
                  activeIcon: Icons.person_rounded,
                  label: '마이',
                  index: 3,
                  controller: navigationController,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required NavigationController controller,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final isTransitioning = controller.isTransitioning.value;

    return GestureDetector(
      onTap: isTransitioning ? null : () => controller.changeIndex(index),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: AnimatedContainer(
          key: ValueKey(isSelected),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.primaryGradient : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Opacity(
            opacity: isTransitioning && !isSelected ? 0.5 : 1.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: Tween(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animation, curve: Curves.elasticOut),
                      ),
                      child: child,
                    );
                  },
                  child: Icon(
                    key: ValueKey('${isSelected}_$index'),
                    isSelected ? activeIcon : icon,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    size: isSelected ? 26 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontSize: isSelected ? 13 : 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
