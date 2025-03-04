import 'package:dio/dio.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import 'package:tentwentyflix/data/models/search_movie_model.dart';

class MovieSearchService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3/search/movie";
  final String apiKey = AppConstants.apiKey;
  final String accessToken = AppConstants.apiAccessToken;

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      // Set up headers with access token for authentication
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      };

      // Making a GET request to search for movies
      final response = await _dio.get(
        "$baseUrl?api_key=$apiKey&query=${Uri.encodeComponent(query)}&language=en-US&page=1&include_adult=false",
        options: Options(headers: headers),
      );

      // Check response status codes and handle errors
      if (response.statusCode == 200) {
        // Successfully retrieved movies, parsing JSON
        return MovieModel.fromJsonList(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid API key or access token");
      } else if (response.statusCode == 404) {
        throw Exception("Not Found: The requested resource was not found");
      } else {
        throw Exception(
          "Failed to search movies. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error searching movies: $e");
    }
  }
}
