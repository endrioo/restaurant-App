import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    // date and time format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecifics = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    // today format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = '$todayDate $timeSpecifics';
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecifics";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
