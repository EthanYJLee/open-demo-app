import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var isTransitioning = false.obs;

  void changeIndex(int index) {
    if (isTransitioning.value || selectedIndex.value == index) return;

    isTransitioning.value = true;

    // 부드러운 전환을 위한 지연
    Future.delayed(const Duration(milliseconds: 100), () {
      selectedIndex.value = index;

      // 전환 완료 후 상태 초기화
      Future.delayed(const Duration(milliseconds: 300), () {
        isTransitioning.value = false;
      });
    });
  }

  void goToHome() {
    changeIndex(0);
  }

  void goToReservation() {
    changeIndex(1);
  }

  void goToCommunity() {
    changeIndex(2);
  }

  void goToMy() {
    changeIndex(3);
  }
}
