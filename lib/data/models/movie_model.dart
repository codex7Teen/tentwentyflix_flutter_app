import 'dart:convert';
import 'package:tentwentyflix/core/utils/app_constants.dart';

//! MovieModel class to represent movie details
class MovieModel {
  //! Unique identifier for the movie
  final int id;
  //! Title of the movie
  final String title;
  //! Short description of the movie (optional)
  final String? overview;
  //! Poster image path (optional)
  final String? posterPath;
  //! Backdrop image path (optional)
  final String? backdropPath;
  //! Release date of the movie
  final String releaseDate;
  //! Average user rating of the movie
  final double voteAverage;
  //! List of genre IDs associated with the movie
  final List<int> genreIds;

  //! Constructor for initializing MovieModel
  MovieModel({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  //! Factory method to create a MovieModel from JSON
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      genreIds: json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : [],
    );
  }

  //! Converts a MovieModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'genre_ids': genreIds,
    };
  }

  //! Converts a JSON string to a list of MovieModel instances
  static List<MovieModel> fromJsonList(Map<String, dynamic> json) {
    if (json.containsKey('results') && json['results'] is List) {
      return (json['results'] as List)
          .map((item) => MovieModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Invalid API response format");
    }
  }

  //! Get the full poster image URL or a placeholder if not available
  String getFullPosterPath() {
    return posterPath != null
        ? '${AppConstants.imageBaseUrl}$posterPath'
        : 'https://via.placeholder.com/500x750?text=No+Image';
  }

  //! Get the first genre name from genre IDs using a lookup map
  String getFirstGenreName(Map<int, String> genreMap) {
    if (genreIds.isEmpty) {
      return "Unknown";
    }
    return genreMap[genreIds.first] ?? "Unknown";
  }

  //! Get a comma-separated list of all genre names
  String getAllGenreNames(Map<int, String> genreMap) {
    if (genreIds.isEmpty) {
      return "Unknown";
    }
    return genreIds.map((id) => genreMap[id] ?? "Unknown").join(', ');
  }
}