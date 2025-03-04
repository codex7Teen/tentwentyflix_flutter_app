import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/data/models/search_movie_model.dart';
import 'package:tentwentyflix/data/repositories/movie_search_repository.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieSearchRepository movieSearchRepository;
  MovieSearchBloc(this.movieSearchRepository) : super(MovieSearchInitial()) {
    //! SEARCH MOVIE EVENT
    on<SearchMovies>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit(MovieSearchInitial());
        return;
      }

      emit(MovieSearchLoading());
      try {
        final movies = await movieSearchRepository.searchMovies(event.query);
        if (movies.isEmpty) {
          emit(MovieSearchEmpty());
        } else {
          emit(MovieSearchLoaded(movies: movies));
        }
      } catch (error) {
        log("BLOC: SEARCH MOVIES ERROR: ${error.toString()}");
        emit(MovieSearchError(message: error.toString()));
      }
    });

    //! CLEAR MOVIE SEARCH EVENT
    on<ClearSearch>((event, emit) {
      emit(MovieSearchInitial());
    });
  }
}
