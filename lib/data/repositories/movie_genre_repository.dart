import 'package:tentwentyflix/data/models/movie_generes_model.dart';
import 'package:tentwentyflix/data/services/movie_genre_service.dart';

class MovieGenreRepository {
  final GenreService _genreService = GenreService();

  Future<List<GenreModel>> getMovieGenres() async {
    return await _genreService.fetchGenres();
  }
}
