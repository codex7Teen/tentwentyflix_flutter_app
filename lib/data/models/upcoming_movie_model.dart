import 'dart:convert';

//! Model class for Upcoming Movies
class UpcomingMovieModel {
  // Unique identifier for the movie
  final int id;
  // Title of the movie
  final String title;
  // Short description of the movie (optional)
  final String? overview;
  // Poster image path (optional)
  final String? posterPath;
  // Backdrop image path (optional)
  final String? backdropPath;
  // Release date of the movie (optional)
  final String? releaseDate;
  // Average user rating of the movie (optional)
  final double? voteAverage;

  //! Constructor for initializing an UpcomingMovieModel
  UpcomingMovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
  });

  //! Factory method to create an UpcomingMovieModel from JSON
  factory UpcomingMovieModel.fromJson(Map<String, dynamic> json) {
    return UpcomingMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }

  //! Converts an UpcomingMovieModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
    };
  }

  //! Converts a JSON string to a list of UpcomingMovieModel instances
  static List<UpcomingMovieModel> fromJsonList(String str) {
    final jsonData = json.decode(str);
    return (jsonData['results'] as List)
        .map((e) => UpcomingMovieModel.fromJson(e))
        .toList();
  }
}
