import 'package:intl/intl.dart';

class FormatDateUtil {
  //! F O R M A T T E D   M O V I E   R E L E A S E   D A T E
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
