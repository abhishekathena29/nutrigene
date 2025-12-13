import 'package:flutter/material.dart';

class AppTheme {
  // Updated color palette for a calm, minimal experience
  static const Color primaryColor = Color(0xFF0EA778); // Emerald
  static const Color secondaryColor = Color(0xFF0EA5E9); // Cool blue accent
  static const Color accentColor = Color(0xFF22C55E); // Vibrant accent
  static const Color backgroundColor = Color(0xFFF7FBFF);
  static const Color surfaceTint = Color(0xFFE7F3EF);
  static const Color cardColor = Colors.white;
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color successColor = Color(0xFF16A34A);

  // Text colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textLight = Colors.white;

  // Shared gradients to keep sections cohesive
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFDCF5EE), Color(0xFFE6F3FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        background: backgroundColor,
        error: errorColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: textLight,
        iconTheme: IconThemeData(color: textLight),
      ),
      textTheme: Typography.blackMountainView
          .apply(bodyColor: textPrimary, displayColor: textPrimary)
          .copyWith(
            headlineMedium: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            titleLarge: const TextStyle(fontWeight: FontWeight.w700),
            titleMedium: const TextStyle(
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            bodyMedium: const TextStyle(color: textSecondary, height: 1.5),
          ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: cardColor.withOpacity(0.96),
        shadowColor: primaryColor.withOpacity(0.08),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textLight,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: secondaryColor.withOpacity(0.15),
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: textLight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: Colors.transparent,
        indicatorColor: primaryColor.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        surfaceTintColor: Colors.transparent,
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? primaryColor
                : textSecondary,
            size: states.contains(MaterialState.selected) ? 28 : 24,
          ),
        ),
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            fontWeight: states.contains(MaterialState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(MaterialState.selected)
                ? primaryColor
                : textSecondary,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: textPrimary,
        contentTextStyle: TextStyle(color: textLight),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withOpacity(0.08),
        selectedColor: primaryColor.withOpacity(0.16),
        labelStyle: const TextStyle(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
