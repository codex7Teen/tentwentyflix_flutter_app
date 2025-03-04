import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import 'package:tentwentyflix/data/models/movie_generes_model.dart';

//! Service class for fetching movie genres from TMDB API
class GenreService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.themoviedb.org/3/genre/movie/list";
  final String endUrl = "&language=en-US";
  final String apiKey = AppConstants.apiKey;

  //! Fetches movie genres from the TMDB API
  Future<List<GenreModel>> fetchGenres() async {
    try {
      //! Making a GET request to fetch genres
      final response = await _dio.get("$baseUrl?api_key=$apiKey$endUrl");

      // Checking response status codes and handling errors accordingly
      if (response.statusCode == 200) {
        // Successfully retrieved genres, parsing JSON
        return GenreModel.fromJsonList(json.encode(response.data));
      } else if (response.statusCode == 401) {
        // Unauthorized - Invalid API key
        throw Exception("Unauthorized: Invalid API key");
      } else if (response.statusCode == 404) {
        // Not Found - The requested resource was not found
        throw Exception("Not Found: The requested resource was not found");
      } else {
        // Other status codes - Generic error message
        throw Exception(
          "Failed to load genres. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      //! Catching any unexpected errors during the API call
      throw Exception("Error fetching genres: $e");
    }
  }
}
