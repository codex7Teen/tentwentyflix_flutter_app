import 'package:tentwentyflix/data/models/trailer_model.dart';
import 'package:tentwentyflix/data/services/trailer_services.dart';

class TrailerRepository {
  final TrailerServices trailerService = TrailerServices();

  Future<List<TrailerModel>> getTrailers(int movieId) async {
    return await trailerService.fetchTrailers(movieId);
  }
}
