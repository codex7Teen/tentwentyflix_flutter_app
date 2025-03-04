part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovies extends MovieSearchEvent {
  final String query;

  const SearchMovies({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearch extends MovieSearchEvent {}