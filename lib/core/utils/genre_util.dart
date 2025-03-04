class GenreUtil {
  // Map of genre IDs to genre names
  static final Map<int, String> genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };
  
  // Get genre name by ID
  static String getGenreName(int id) {
    return genreMap[id] ?? 'Unknown';
  }
  
  // Get genre names for a list of IDs
  static String getGenreNames(List<int> ids) {
    if (ids.isEmpty) {
      return "Unknown";
    }
    return ids
        .map((id) => genreMap[id] ?? "Unknown")
        .join(', ');
  }
  
  // Get the first genre name from a list of IDs
  static String getFirstGenreName(List<int> ids) {
    if (ids.isEmpty) {
      return "Unknown";
    }
    return genreMap[ids.first] ?? "Unknown";
  }
}