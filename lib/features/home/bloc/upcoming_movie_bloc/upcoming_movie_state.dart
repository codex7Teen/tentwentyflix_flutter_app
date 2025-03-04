part of 'upcoming_movie_bloc.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();

  @override
  List<Object> get props => [];
}

final class UpcomingMovieInitial extends UpcomingMovieState {}

final class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final List<UpcomingMovieModel> movies;
  const UpcomingMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class UpcomingMovieError extends UpcomingMovieState {
  final String message;
  const UpcomingMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
