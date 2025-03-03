import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/main_bottom_navigation/main_bottom_navigation.dart';

//! ROOT
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEN_TWENTYFLIX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blackColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MainBottomNavigation(key: bottomNavKey),
    );
  }
}
