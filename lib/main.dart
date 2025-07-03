import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'constants/app_colors.dart';
import 'controllers/navigation_controller.dart';
import 'widgets/main_screen.dart';
import 'pages/reservation/reservation_form_page.dart';
import 'pages/community/post_detail_page.dart';
import 'pages/community/post_write_page.dart';

void main() {
  // GetX 컨트롤러 초기화
  Get.put(NavigationController());

  runApp(const ProviderScope(child: OpenDemoApp()));
}

class OpenDemoApp extends StatelessWidget {
  const OpenDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '기도',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MainScreen()),
        GetPage(
            name: '/reservation/form', page: () => const ReservationFormPage()),
        GetPage(name: '/community/detail', page: () => const PostDetailPage()),
        GetPage(name: '/community/write', page: () => const PostWritePage()),
      ],
    );
  }
}
