import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/data/services/movie_search_service.dart';

class MovieSearchRepository {
  final MovieSearchService _searchService = MovieSearchService();

  Future<List<MovieModel>> searchMovies(String query) async {
    return await _searchService.searchMovies(query);
  }
}
