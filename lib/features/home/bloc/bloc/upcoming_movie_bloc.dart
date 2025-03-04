import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/data/models/upcoming_movie_model.dart';
import 'package:tentwentyflix/data/repositories/upcoming_movie_repository.dart';

part 'upcoming_movie_event.dart';
part 'upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final UpcomingMovieRepository movieRepository;
  UpcomingMovieBloc(this.movieRepository) : super(UpcomingMovieInitial()) {
    //! FETCH UPCOMING MOVIES EVENT
    on<FetchUpcomingMovies>((event, emit) async {
      emit(UpcomingMovieLoading());
      try {
        final movies = await movieRepository.getUpcomingMovies();
        emit(UpcomingMovieLoaded(movies: movies));
      } catch (error) {
        log("BLOC: FETCH MOVIES ERROR: ${error.toString()}");
        emit(UpcomingMovieError(message: error.toString()));
      }
    });
  }
}
