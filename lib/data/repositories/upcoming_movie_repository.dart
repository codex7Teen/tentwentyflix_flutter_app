import 'package:tentwentyflix/data/models/upcoming_movie_model.dart';
import 'package:tentwentyflix/data/services/upcoming_movie_service.dart';

class UpcomingMovieRepository {
  final UpcomingMovieService _movieService = UpcomingMovieService();

  Future<List<UpcomingMovieModel>> getUpcomingMovies() async {
    return await _movieService.fetchUpcomingMovies();
  }
}
