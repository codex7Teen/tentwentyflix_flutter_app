import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/data/repositories/trailer_repository.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'trailer_event.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final TrailerRepository trailerRepository;
  TrailerBloc(this.trailerRepository) : super(TrailerInitialState()) {
    on<LoadTrailerEvent>(_onLoadTrailer);
    on<PlayTrailerEvent>(_onPlayTrailer);
    on<CloseTrailerEvent>(_onCloseTrailer);
  }

  Future<void> _onLoadTrailer(
    LoadTrailerEvent event,
    Emitter<TrailerState> emit,
  ) async {
    emit(TrailerLoadingState());
    try {
      final trailers = await trailerRepository.getTrailers(event.movieId);
      emit(TrailerLoadedState(trailers));
    } catch (e) {
      emit(TrailerErrorState('Failed to load trailers: ${e.toString()}'));
    }
  }

  Future<void> _onPlayTrailer(
    PlayTrailerEvent event,
    Emitter<TrailerState> emit,
  ) async {
    final playerController = YoutubePlayerController(
      initialVideoId: event.videoKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );

    emit(
      TrailerPlayingState(event.videoKey, playerController: playerController),
    );
  }

  Future<void> _onCloseTrailer(
    CloseTrailerEvent event,
    Emitter<TrailerState> emit,
  ) async {
    final currentState = state;
    if (currentState is TrailerPlayingState) {
      currentState.playerController?.dispose();
    }
    emit(TrailerInitialState());
  }
}
