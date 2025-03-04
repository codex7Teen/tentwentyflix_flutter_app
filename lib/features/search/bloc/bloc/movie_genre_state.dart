part of 'movie_genre_bloc.dart';

abstract class MovieGenreState extends Equatable {
  const MovieGenreState();

  @override
  List<Object> get props => [];
}

final class MovieGenreInitial extends MovieGenreState {}

final class MovieGenreLoading extends MovieGenreState {}

class MovieGenreLoaded extends MovieGenreState {
  final List<GenreModel> genres;
  const MovieGenreLoaded({required this.genres});

  @override
  List<Object> get props => [genres];
}

class MovieGenreError extends MovieGenreState {
  final String message;
  const MovieGenreError({required this.message});

  @override
  List<Object> get props => [message];
}
