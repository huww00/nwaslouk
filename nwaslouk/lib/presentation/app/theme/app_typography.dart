import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme textTheme = TextTheme(
    displaySmall: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 28, color: AppColors.text),
    headlineSmall: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.text),
    titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.text),
    bodyLarge: GoogleFonts.roboto(fontSize: 16, color: AppColors.text),
    bodyMedium: GoogleFonts.roboto(fontSize: 14, color: AppColors.textMuted),
    labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
  );
}