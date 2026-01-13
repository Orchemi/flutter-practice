import 'package:flutter/material.dart';

/// 앱에서 사용하는 색상 정의
///
/// 사용법:
/// ```dart
/// Container(color: AppColors.primary)
/// ```
abstract class AppColors {
  // Primary 색상 (브랜드 메인 컬러)
  static const Color primary = Color(0xFF3B82F6); // blue-500
  static const Color primaryLight = Color(0xFF60A5FA); // blue-400
  static const Color primaryDark = Color(0xFF2563EB); // blue-600

  // Secondary 색상 (보조 컬러)
  static const Color secondary = Color(0xFF8B5CF6); // violet-500

  // Neutral 색상 (회색 계열)
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Semantic 색상 (의미를 가진 색상)
  static const Color success = Color(0xFF22C55E); // green-500
  static const Color warning = Color(0xFFF59E0B); // amber-500
  static const Color error = Color(0xFFEF4444); // red-500
  static const Color info = Color(0xFF3B82F6); // blue-500

  // 배경색
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF9FAFB);

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textDisabled = Color(0xFF9CA3AF); // gray-400
}
