import 'package:flutter/material.dart';

abstract class AppColors {
  // Cores principais
  static const Color backgroundColor = Color(0xFF202123);
  static const Color mainColor = Color(0xFFffa559);
  static const Color lightBackgroundColor = Color(0xFF343541);
  
  // Cores adicionais para UI/UX
  static const Color cardColor = Color(0xFF2A2B32);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color dividerColor = Color(0xFF404040);
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFffa559), Color(0xFFff8c42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
