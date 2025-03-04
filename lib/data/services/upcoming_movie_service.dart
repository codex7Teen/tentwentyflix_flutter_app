import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import '../models/upcoming_movie_model.dart';

class UpcomingMovieService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3/movie/upcoming";
  final String apiKey = AppConstants.apiKey;

  //! Fetches upcoming movies from the TMDB API
  //! Uses Dio for network requests and handles different HTTP status codes
  Future<List<UpcomingMovieModel>> fetchUpcomingMovies() async {
    try {
      //! Making a GET request to fetch upcoming movies
      final response = await _dio.get("$baseUrl?api_key=$apiKey");

      // Checking response status codes and handling errors accordingly
      if (response.statusCode == 200) {
        // Successfully retrieved movie data, parsing JSON
        return UpcomingMovieModel.fromJsonList(json.encode(response.data));
      } else if (response.statusCode == 401) {
        // Unauthorized - Invalid API key
        throw Exception("Unauthorized: Invalid API key");
      } else if (response.statusCode == 404) {
        // Not Found - The requested resource was not found
        throw Exception("Not Found: The requested resource was not found");
      } else {
        // Other status codes - Generic error message
        throw Exception(
          "Failed to load movies. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      //! Catching any unexpected errors during the API call
      throw Exception("Error fetching movies: $e");
    }
  }
}
