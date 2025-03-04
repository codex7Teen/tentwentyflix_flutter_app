import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerScreen extends StatelessWidget {
  final String videoKey;
  final YoutubePlayerController playerController;

  const TrailerPlayerScreen({
    super.key,
    required this.videoKey,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
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
            // Automatically exit when trailer ends
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
          context.read<TrailerBloc>().add(CloseTrailerEvent());
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
