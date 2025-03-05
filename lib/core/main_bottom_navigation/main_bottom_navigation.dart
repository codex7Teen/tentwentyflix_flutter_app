import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/features/home/presentation/screens/home_screen.dart';
import 'package:tentwentyflix/features/search/presentation/screens/search_screen.dart';
import 'package:tentwentyflix/shared/navigation_helper.dart';

// global key for the MainBottomNavigation state
final GlobalKey<MainBottomNavigationState> bottomNavKey =
    GlobalKey<MainBottomNavigationState>();

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  MainBottomNavigationState createState() => MainBottomNavigationState();
}

class MainBottomNavigationState extends State<MainBottomNavigation> {
  // Current selected index for the bottom navigation
  int _selectedIndex = 1;

  // List of screens to display based on navigation index
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Initialize screens in initState to avoid recreation on each build
    _screens = [
      const Center(
        child: Text('Dashboard Screen'),
      ), // Placeholder for Dashboard
      ScreenHome(onSearchTap: navigateToSearch), // Watch screen with callback
      const Center(
        child: Text('Media Library Screen'),
      ), // Placeholder for Media Library
      const Center(child: Text('More Screen')), // Placeholder for More
    ];
  }

  // Public method to navigate to search screen
  void navigateToSearch() {
    NavigationHelper.navigateToWithoutReplacement(
      context,
      _buildSearchScreenWithNav(),
    );
  }

  // Build method for search screen with navigation
  Widget _buildSearchScreenWithNav() {
    return Scaffold(
      body: const ScreenSearch(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // Method to handle bottom navigation item taps
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Extract bottom navigation bar as a separate widget to reuse
  Widget buildBottomNavigationBar() {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight > 500 ? screenHeight * 0.096 : screenHeight * 0.195,
      decoration: BoxDecoration(
        color: AppColors.darkPurpleThemeColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(37),
          topRight: Radius.circular(37),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BottomNavigationBar(
          // Custom font styles for labels
          selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.roboto(fontSize: 12.2),

          // Current selected index
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (Navigator.canPop(context) && index != _selectedIndex) {
              // If we're on a pushed screen, pop back first
              Navigator.pop(context);
            }
            onItemTapped(index);
          },

          // Colors for selected and unselected items
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.darkGreyThemeColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,

          // Navigation items
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the selected screen
      body: _screens[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
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
