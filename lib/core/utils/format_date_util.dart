import 'package:intl/intl.dart';

class FormatDateUtil {
  // Formatted Movie release date
  static String formatReleaseDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return "Release date not available";
    }
  }
}
