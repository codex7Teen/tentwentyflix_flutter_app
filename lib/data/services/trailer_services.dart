import 'package:dio/dio.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import 'package:tentwentyflix/data/models/trailer_model.dart';

class TrailerServices {
  final Dio _dio = Dio();

  //! FETCH TRAILER
  Future<List<TrailerModel>> fetchTrailers(int movieId) async {
    final String url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${AppConstants.apiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;

        // Filter and prioritize official trailers
        List<TrailerModel> trailers =
            (jsonResponse['results'] as List)
                .map((item) => TrailerModel.fromJson(item))
                .where(
                  (trailer) =>
                      trailer.type.toLowerCase() == 'trailer' ||
                      trailer.type.toLowerCase() == 'teaser',
                )
                .toList();

        // Sort trailers: Official first, then by published date
        trailers.sort((a, b) {
          // Add sorting logic if needed
          return 0;
        });

        return trailers;
      } else if (response.statusCode == 404) {
        throw Exception('Trailers not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server error, please try again later');
      } else {
        throw Exception(
          'Failed to load trailers, Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching trailers: $e');
    }
  }
}
