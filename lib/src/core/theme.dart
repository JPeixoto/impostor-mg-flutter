import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors (Vibrant Grid)
  static const Color primary = Color(0xFFFF2D55); // Vibrant Red/Pink
  static const Color secondary = Color(0xFF121212); // Dark Charcoal
  static const Color accent = Color(0xFFFFFFFF); // White
  static const Color success = Color(0xFF2CB67D);
  static const Color error = Color(0xFFFF4B4B);

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(32));

  // --- Light Theme Definition ---
  static const Color _lightBg = Color(0xFFF4F6FD); // Soft Blue-Grey
  static const Color _lightSurface = Color(0xFFFFFFFF); // White
  static const Color _lightTextPrimary = Color(0xFF121212); // Black
  static const Color _lightTextSecondary = Color(0xFF72757E); // Grey
  static const Color _lightGrid = Color(0xFFE0E5F5); // Subtle Grid

  static ThemeData get lightTheme {
    final textTheme = _buildTextTheme(_lightTextPrimary);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBg,
      primaryColor: primary,
      dividerColor: _lightGrid,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: _lightSurface,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _lightTextPrimary,
        onSurfaceVariant: _lightTextSecondary,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: _lightTextPrimary),
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
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: _lightTextSecondary.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: _lightTextSecondary.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: GoogleFonts.outfit(
          color: _lightTextSecondary.withValues(alpha: 0.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      cardTheme: CardThemeData(
        color: _lightSurface,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
        margin: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(color: _lightTextPrimary, size: 24),
    );
  }

  // --- Dark Theme Definition ---
  static const Color _darkBg = Color(0xFF101010); // True Black
  static const Color _darkSurface = Color(
    0xFF2A2A2A,
  ); // Lighter Dark Grey Cards for better contrast
  static const Color _darkTextPrimary = Color(0xFFFFFFFF); // White
  static const Color _darkTextSecondary = Color(0xFFAAAAAA); // Light Grey
  static const Color _darkGrid = Color(0xFF333333); // Lighter Dark Grid

  static ThemeData get darkTheme {
    final textTheme = _buildTextTheme(_darkTextPrimary);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBg,
      primaryColor: primary,
      dividerColor: _darkGrid,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: _darkSurface,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _darkTextPrimary,
        onSurfaceVariant: _darkTextSecondary,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: _darkTextPrimary),
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
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        hintStyle: GoogleFonts.outfit(
          color: _darkTextSecondary.withValues(alpha: 0.6),
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
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.15), // Stronger border
            width: 1,
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(color: _darkTextPrimary, size: 24),
    );
  }

  // --- Shared Helpers ---

  static List<BoxShadow> get softShadows => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: GoogleFonts.outfit(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.5,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color.withValues(alpha: 0.8),
      ),
      labelLarge: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.5,
      ),
    );
  }
}
