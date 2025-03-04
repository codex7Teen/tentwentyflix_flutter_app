part of 'movie_genre_bloc.dart';

abstract class MovieGenreEvent extends Equatable {
  const MovieGenreEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieGenre extends MovieGenreEvent {}
