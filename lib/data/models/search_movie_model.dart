import 'package:tentwentyflix/core/utils/app_constants.dart';

class MovieModel {
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;

  MovieModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genreIds:
          json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'genre_ids': genreIds,
    };
  }

  static List<MovieModel> fromJsonList(Map<String, dynamic> data) {
    return (data['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  String getFullPosterPath() {
    return posterPath != null
        ? '${AppConstants.imageBaseUrl}$posterPath'
        : 'https://via.placeholder.com/500x750?text=No+Image';
  }

  // Get the first genre name from genre IDs using a lookup map
  String getFirstGenreName(Map<int, String> genreMap) {
    if (genreIds.isEmpty) {
      return "Unknown";
    }
    return genreMap[genreIds.first] ?? "Unknown";
  }

  // Get a comma-separated list of all genre names
  String getAllGenreNames(Map<int, String> genreMap) {
    if (genreIds.isEmpty) {
      return "Unknown";
    }
    return genreIds.map((id) => genreMap[id] ?? "Unknown").join(', ');
  }
}
