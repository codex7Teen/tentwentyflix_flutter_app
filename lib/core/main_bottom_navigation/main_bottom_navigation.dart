import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/features/home/presentation/home_screen.dart';

class MainBottomNavigation extends StatelessWidget {
  MainBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main screen content
      body: ScreenHome(),
      bottomNavigationBar: Container(
        height: MediaQuery.sizeOf(context).height * 0.096,
        decoration: BoxDecoration(
          color: AppColors.darkPurpleThemeColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(37),
            topRight: Radius.circular(37),
          ),
        ),
        child: BottomNavigationBar(
          // Custom font styles for labels
          selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.roboto(fontSize: 12.2),

          // Default selected index
          currentIndex: 1,

          // Colors for selected and unselected items
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.darkGreyThemeColor,

          // Fixed navigation bar
          type: BottomNavigationBarType.fixed,

          // Transparent background
          backgroundColor: Colors.transparent,

          // Generating navigation items dynamically
          items: List.generate(navBarIcons.length, (index) {
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Image.asset(navBarIcons[index], width: 32),
              ),
              label: navBarLabels[index],
            );
          }),
        ),
      ),
    );
  }

  // Navigation bar labels
  final List<String> navBarLabels = [
    'Dashboard',
    'Watch',
    'Media Library',
    'More',
  ];

  // Navigation bar icons
  final List<String> navBarIcons = [
    'assets/icons/dashboard_icon.png',
    'assets/icons/watch_icon.png',
    'assets/icons/media_lib_icon.png',
    'assets/icons/more_icon.png',
  ];
}
