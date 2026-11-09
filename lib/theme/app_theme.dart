import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Background & Surfaces
  static const Color background = Color(0xFF101417);
  static const Color surfaceLowest = Color(0xFF0B0F12);
  static const Color surfaceLow = Color(0xFF181C1F);
  static const Color surface = Color(0xFF101417);
  static const Color surfaceContainer = Color(0xFF1C2023);
  static const Color surfaceContainerHigh = Color(0xFF262A2E);
  static const Color surfaceContainerHighest = Color(0xFF313539);
  static const Color surfaceVariant = Color(0xFF313539);
  static const Color surfaceBright = Color(0xFF363A3D);

  // Accent Colors
  static const Color primary = Color(0xFFFFFFFF);
  static const Color primaryLime = Color(0xFFC3F400); // Electric lime primary accent
  static const Color primaryLimeGlow = Color(0x66C3F400);
  static const Color primaryLimeDim = Color(0xFFABD600);
  static const Color onPrimary = Color(0xFF161E00);
  static const Color onPrimaryContainer = Color(0xFF283500);

  // Secondary Accents (Cyan)
  static const Color secondaryCyan = Color(0xFF00E3FD);
  static const Color onSecondary = Color(0xFF00363D);
  static const Color secondaryContainer = Color(0x3300E3FD);

  // Tertiary Accents (Emerald / Mint)
  static const Color tertiaryEmerald = Color(0xFF6FFBBE);
  static const Color onTertiary = Color(0xFF003824);
  static const Color tertiaryContainer = Color(0x336FFBBE);

  // Status & Error
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  // Text & Borders
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFE0E3E7);
  static const Color onSurfaceVariant = Color(0xFF8E9BAE);
  static const Color outline = Color(0xFF1F2933);
  static const Color outlineVariant = Color(0xFF2E3A46);
  static const Color divider = Color(0xFF1F2933);
}

class AppTypography {
  static TextStyle displayHero({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      height: 1.1,
      letterSpacing: -1.2,
      color: color,
    );
  }

  static TextStyle headlineLg({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.5,
      color: color,
    );
  }

  static TextStyle headlineMd({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: -0.2,
      color: color,
    );
  }

  static TextStyle headlineSm({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle metricLg({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      height: 1.1,
      letterSpacing: -0.8,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle metricMd({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.3,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle labelLg({Color color = AppColors.textPrimary}) {
    return GoogleFonts.lexend(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
      color: color,
    );
  }

  static TextStyle labelMd({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.lexend(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
      color: color,
    );
  }

  static TextStyle labelSm({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.lexend(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: color,
    );
  }

  static TextStyle bodyLg({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle bodyMd({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: color,
    );
  }

  static TextStyle bodySm({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.3,
      color: color,
    );
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryLime,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLime,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondaryCyan,
        onSecondary: AppColors.onSecondary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
        onError: AppColors.surfaceLowest,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: AppTypography.headlineMd(),
        bodyMedium: AppTypography.bodyMd(),
        bodySmall: AppTypography.bodySm(),
      ),
      dividerColor: AppColors.divider,
      cardColor: AppColors.surfaceContainer,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background.withOpacity(0.9),
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
