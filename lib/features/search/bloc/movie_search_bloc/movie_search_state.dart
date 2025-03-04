part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieModel> movies;

  const MovieSearchLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
