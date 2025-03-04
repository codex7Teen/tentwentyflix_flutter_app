import 'package:equatable/equatable.dart';
import 'package:tentwentyflix/data/models/trailer_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class TrailerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrailerInitialState extends TrailerState {}

class TrailerLoadingState extends TrailerState {}

class TrailerLoadedState extends TrailerState {
  final List<TrailerModel> trailers;
  TrailerLoadedState(this.trailers);

  @override
  List<Object?> get props => [trailers];
}

class TrailerPlayingState extends TrailerState {
  final String videoKey;
  YoutubePlayerController? playerController;

  TrailerPlayingState(this.videoKey, {this.playerController});

  @override
  List<Object?> get props => [videoKey, playerController];
}

class TrailerErrorState extends TrailerState {
  final String errorMessage;
  TrailerErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
