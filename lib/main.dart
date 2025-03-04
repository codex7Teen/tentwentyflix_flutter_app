import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/config/bloc_providers.dart';
import 'package:tentwentyflix/core/main_bottom_navigation/main_bottom_navigation.dart';

//!  R O O T
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //!  I N I T I A L I Z E  W I D G E T S
  runApp(const MyApp()); //!  S T A R T  A P P
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //!  B L O C  -  P R O V I D E R S
      providers: AppBlocProviders.providers,
      child: MaterialApp(
        title: 'TEN_TWENTYFLIX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.whiteColor,
          ), //!  W H I T E   T H E M E
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            titleTextStyle: AppTextstyles.headingTextPoppinsDarkPurple,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: MainBottomNavigation(
          key: bottomNavKey,
        ), //!  M A I N   N A V I G A T I O N
      ),
    );
  }
}
