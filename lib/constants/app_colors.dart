import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - 더 부드럽고 현대적인 블루
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary Colors - 따뜻한 오렌지
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryLight = Color(0xFFFBBF24);
  static const Color secondaryDark = Color(0xFFD97706);

  // Background Colors - 더 부드러운 그레이
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text Colors - 더 부드러운 텍스트 색상
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);

  // Status Colors - 더 부드러운 상태 색상
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Reservation Status Colors
  static const Color reserved = Color(0xFF10B981);
  static const Color completed = Color(0xFF3B82F6);
  static const Color cancelled = Color(0xFFEF4444);

  // Divider & Border Colors - 더 부드러운 구분선
  static const Color divider = Color(0xFFE2E8F0);
  static const Color border = Color(0xFFE2E8F0);

  // Shadow Colors - 더 부드러운 그림자
  static const Color shadow = Color(0x0A000000);

  // Gradient Colors - 더 아름다운 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Card Colors
  static const Color cardShadow = Color(0x0A000000);
  static const Color cardBorder = Color(0xFFF1F5F9);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF6366F1);
  static const Color buttonSecondary = Color(0xFFF59E0B);
  static const Color buttonSuccess = Color(0xFF10B981);
  static const Color buttonError = Color(0xFFEF4444);

  // Icon Colors
  static const Color iconPrimary = Color(0xFF6366F1);
  static const Color iconSecondary = Color(0xFF64748B);
  static const Color iconSuccess = Color(0xFF10B981);
  static const Color iconWarning = Color(0xFFF59E0B);
  static const Color iconError = Color(0xFFEF4444);
}
