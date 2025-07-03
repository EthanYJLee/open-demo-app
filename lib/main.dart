import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/app_colors.dart';
import 'controllers/navigation_controller.dart';
import 'widgets/main_screen.dart';
import 'pages/reservation/reservation_form_page.dart';
import 'pages/community/post_detail_page.dart';
import 'pages/community/post_write_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // env 로드 (파일이 없어도 계속 진행)
  try {
    await dotenv.load(fileName: 'assets/config/.env');
  } catch (e) {
    print('Warning: .env file not found. Using default values.');
  }

  // Supabase 초기화
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? 'your_supabase_url_here';
  final supabaseAnonKey =
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'your_supabase_anon_key_here';

  print('Initializing Supabase with URL: $supabaseUrl');
  print('Initializing Supabase with Anon Key: $supabaseAnonKey');

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    print('Supabase initialized successfully');

    // 초기화 후 클라이언트 상태 확인
    final client = Supabase.instance.client;
    print('Supabase client available: ${client != null}');
  } catch (e) {
    print('Failed to initialize Supabase: $e');
    // 초기화 실패시에도 앱은 계속 실행
  }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // GetX 컨트롤러 초기화
  Get.put(NavigationController());

  runApp(const ProviderScope(child: OpenDemoApp()));
}

class OpenDemoApp extends StatelessWidget {
  const OpenDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

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
