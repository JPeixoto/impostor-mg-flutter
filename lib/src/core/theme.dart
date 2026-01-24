import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors (Vibrant Grid)
  static const Color primary = Color(0xFFF05D2A); // Burnt Orange
  static const Color secondary = Color(0xFF1E4B45); // Pine
  static const Color accent = Color(0xFFFFFBF4); // Warm White
  static const Color success = Color(0xFF2E9B6C);
  static const Color error = Color(0xFFE5484D);
  static const Color tertiary = Color(0xFFE0B55B); // Brass

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(28));

  // --- Light Theme Definition ---
  static const Color _lightBg = Color(0xFFF8F2EA); // Warm Paper
  static const Color _lightSurface = Color(0xFFFFFBF4); // Warm White
  static const Color _lightField = Color(0xFFF1E7DB); // Input Fill
  static const Color _lightTextPrimary = Color(0xFF1F2A33); // Ink
  static const Color _lightTextSecondary = Color(0xFF5E6A73); // Slate
  static const Color _lightGrid = Color(0xFFE3D7C9); // Soft Grid

  static ThemeData get lightTheme {
    final textTheme = _buildTextTheme(_lightTextPrimary);
    const colorScheme = ColorScheme.light(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: _lightSurface,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _lightTextPrimary,
      onSurfaceVariant: _lightTextSecondary,
      onError: Colors.white,
      outline: _lightGrid,
      outlineVariant: _lightGrid,
      shadow: Color(0x1F000000),
      surfaceTint: Colors.transparent,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBg,
      primaryColor: primary,
      dividerColor: _lightGrid,
      hintColor: _lightTextSecondary,
      disabledColor: _lightTextSecondary.withValues(alpha: 0.45),
      shadowColor: Colors.black.withValues(alpha: 0.12),
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: _lightTextPrimary),
        surfaceTintColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _lightTextPrimary,
          side: const BorderSide(color: _lightGrid),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: _lightGrid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: _lightGrid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: GoogleFonts.sora(
          color: _lightTextSecondary.withValues(alpha: 0.7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      cardTheme: CardThemeData(
        color: _lightSurface,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: cardRadius,
          side: BorderSide(color: _lightGrid.withValues(alpha: 0.6), width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _lightField,
        selectedColor: primary.withValues(alpha: 0.2),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: _lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: _lightGrid.withValues(alpha: 0.6)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconTheme: const IconThemeData(color: _lightTextPrimary, size: 24),
    );
  }

  // --- Dark Theme Definition ---
  static const Color _darkBg = Color(0xFF0C1116); // Midnight
  static const Color _darkSurface = Color(0xFF151D25); // Ink Surface
  static const Color _darkField = Color(0xFF1C2630); // Input Fill
  static const Color _darkTextPrimary = Color(0xFFF6EFE6); // Warm White
  static const Color _darkTextSecondary = Color(0xFFB2BDC6); // Mist
  static const Color _darkGrid = Color(0xFF23303A); // Grid

  static ThemeData get darkTheme {
    final textTheme = _buildTextTheme(_darkTextPrimary);
    const colorScheme = ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: _darkSurface,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _darkTextPrimary,
      onSurfaceVariant: _darkTextSecondary,
      onError: Colors.white,
      outline: _darkGrid,
      outlineVariant: _darkGrid,
      shadow: Color(0x66000000),
      surfaceTint: Colors.transparent,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBg,
      primaryColor: primary,
      dividerColor: _darkGrid,
      hintColor: _darkTextSecondary,
      disabledColor: _darkTextSecondary.withValues(alpha: 0.45),
      shadowColor: Colors.black.withValues(alpha: 0.3),
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: _darkTextPrimary),
        surfaceTintColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkTextPrimary,
          side: const BorderSide(color: _darkGrid),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: _darkGrid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: _darkGrid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: GoogleFonts.sora(
          color: _darkTextSecondary.withValues(alpha: 0.7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      cardTheme: CardThemeData(
        color: _darkSurface,
        elevation: 0, // Flat in dark mode, use border
        shadowColor: Colors.black.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: cardRadius,
          side: BorderSide(color: _darkGrid.withValues(alpha: 0.8), width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _darkField,
        selectedColor: primary.withValues(alpha: 0.25),
        labelStyle: textTheme.labelLarge?.copyWith(
          color: _darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: _darkGrid.withValues(alpha: 0.8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      iconTheme: const IconThemeData(color: _darkTextPrimary, size: 24),
    );
  }

  // --- Shared Helpers ---

  static List<BoxShadow> get softShadows => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: GoogleFonts.sora(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -1.2,
      ),
      displayMedium: GoogleFonts.sora(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.6,
      ),
      headlineLarge: GoogleFonts.sora(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      headlineMedium: GoogleFonts.sora(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleLarge: GoogleFonts.sora(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: GoogleFonts.sora(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      bodyLarge: GoogleFonts.sora(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodyMedium: GoogleFonts.sora(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color.withValues(alpha: 0.8),
      ),
      labelLarge: GoogleFonts.sora(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.5,
      ),
    );
  }
}
