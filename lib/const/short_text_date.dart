import 'package:intl/intl.dart';

class FormatTime {
  static String formateTime(String dateString) {
    try {
      DateTime utcTime = DateTime.parse(dateString).toUtc(); // Input must be UTC
      DateTime bstTime = utcTime.add(const Duration(hours: 6));
      return DateFormat('hh:mm a').format(bstTime); // or 'h:mm a'
    } catch (e) {
      return 'Invalid Time';
    }
  }


  static String formateDateTimeMonth(String isoString) {
    try {
      DateTime utcTime = DateTime.parse(isoString).toUtc();
      DateTime bstTime = utcTime.add(const Duration(hours: 6));
      return DateFormat('MMM d, y, h:mma').format(bstTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  static String formateDate(String dateString) {
    DateTime utcTime = DateTime.parse(dateString).toUtc();
    DateTime bstTime = utcTime.add(const Duration(hours: 6));
    String formattedTime = DateFormat('dd/MM/yyyy').format(bstTime); // fixed MM
    return formattedTime;
  }

  static String formateDateMonth(String dateString) {
    DateTime utcTime = DateTime.parse(dateString).toUtc();
    DateTime bstTime = utcTime.add(const Duration(hours: 6));
    String formattedTime = DateFormat('dd MMM,yyyy').format(bstTime);
    return formattedTime;
  }

  static String profileDateOfBirth(String dateString) {
    DateTime utcTime = DateTime.parse(dateString).toUtc();
    DateTime bstTime = utcTime.add(const Duration(hours: 6));
    String formattedTime = DateFormat('yyyy-MM-dd').format(bstTime);
    return formattedTime;
  }


}
class ShortText {
  static String getShortText(String? text, {int maxLength = 20}) {
    if (text == null) return '';
    return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
  }
}
