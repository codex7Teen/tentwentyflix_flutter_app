import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/details/presentation/widgets/movie_detail_screen_widgets.dart';

class ScreenMovieDetails extends StatelessWidget {
  //! M O V I E  M O D E L
  final MovieModel movieModel;
  const ScreenMovieDetails({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    //! S E T  S T A T U S  B A R  S T Y L E
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor, // Transparent background
        statusBarIconBrightness: Brightness.light, // Light icons
      ),
    );

    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //! S T A C K
            Stack(
              children: [
                MovieDetailScreenWidgets.buildImage(screenHeight, movieModel),

                //! B L A C K  G R A D I E N T  S H A D O W
                MovieDetailScreenWidgets.buildShadowEffect(screenHeight),

                //! W A T C H  &  G E T  T I C K E T S
                MovieDetailScreenWidgets.buildMovieWatchAndGetTickets(
                  movieModel,
                  context,
                ),

                //! B A C K  B U T T O N  &  W A T C H  T E X T
                MovieDetailScreenWidgets.buildBackbuttonAndWatchtext(context),
              ],
            ),

            //! M O V I E  D E T A I L S
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! G E N R E S - T E X T
                  MovieDetailScreenWidgets.buildGenresText(),
                  SizedBox(height: 14),

                  //! A L L - G E N R E S
                  MovieDetailScreenWidgets.buildAllGenres(movieModel),
                  SizedBox(height: 14),

                  //! D I V I D E R
                  Divider(color: AppColors.lightGreyColor, thickness: 0),
                  SizedBox(height: 12),

                  //! O V E R V I E W - T E X T
                  MovieDetailScreenWidgets.buildOverviewText(),
                  SizedBox(height: 15),

                  //! M O V I E - D E S C R I P T I O N
                  MovieDetailScreenWidgets.buildMovieDescription(movieModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
