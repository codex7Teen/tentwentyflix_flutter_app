import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerScreen extends StatelessWidget {
  //! V I D E O  K E Y  &  C O N T R O L L E R
  final String videoKey;
  final YoutubePlayerController playerController;

  const TrailerPlayerScreen({
    super.key,
    required this.videoKey,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    //! S C A F F O L D
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: playerController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.blueThemeColor,
          onReady: () {
            playerController.play();
          },
          onEnded: (metaData) {
            //! A U T O - C L O S E   O N   E N D
            context.read<TrailerBloc>().add(CloseTrailerEvent());
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        child: Text(
          'Done',
          style: AppTextstyles.headingTextPoppinsDarkPurple.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          //! C L O S E  O N  T A P
          context.read<TrailerBloc>().add(CloseTrailerEvent());
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
