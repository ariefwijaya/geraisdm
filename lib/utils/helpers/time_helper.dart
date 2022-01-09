import 'package:easy_localization/easy_localization.dart';

class TimeHelper {
  TimeHelper._();
  static String dateTimeToMonthYear(DateTime date, [String? locale]) {
    return DateFormat(
            'MMMM yyyy', locale != null && locale.isNotEmpty ? locale : null)
        .format(date);
  }

  static String dateTimeToYearMonthDay(DateTime date, [String? locale]) {
    return DateFormat(
            'yyyy-MM-dd', locale != null && locale.isNotEmpty ? locale : null)
        .format(date);
  }

  static String dateTimeToDayMonthYear(DateTime date, [String? locale]) {
    return DateFormat(
            'd MMMM yyyy', locale != null && locale.isNotEmpty ? locale : null)
        .format(date);
  }

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    final List<DateTime> days = [];
    final diff = endDate.difference(startDate).inDays;
    for (int i = 0; i <= (diff <= 3 ? diff + 4 : diff); i++) {
      final next = startDate.add(Duration(days: i));
      days.add(next);
    }
    return days;
  }
}
