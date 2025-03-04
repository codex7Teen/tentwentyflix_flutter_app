part of 'trailer_bloc.dart';

abstract class TrailerEvent extends Equatable {
  const TrailerEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrailerEvent extends TrailerEvent {
  final int movieId;
  const LoadTrailerEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class PlayTrailerEvent extends TrailerEvent {
  final String videoKey;
  const PlayTrailerEvent(this.videoKey);

  @override
  List<Object?> get props => [videoKey];
}

class CloseTrailerEvent extends TrailerEvent {}
