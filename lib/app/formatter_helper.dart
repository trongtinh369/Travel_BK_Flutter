import 'package:intl/intl.dart';

class FormatterHelper {
  static String formatDate(DateTime d) {
    two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }

  static String formatCurrency(int money) {
    var numFormatter = NumberFormat("#,##0", "fr_FR");
    return "${numFormatter.format(money)} VNĐ";
  }

  static String formatDuration(Duration duration) {
    int seconds = duration.inSeconds;
    int yearInSeconds = (365 * 24 * 60 * 60);
    int monthInSeconds = (30 * 24 * 60 * 60);
    int dayInSeconds = (24 * 60 * 60);
    int hourInSeconds = (60 * 60);
    int minuteInSeconds = (60);

    int years = (seconds / yearInSeconds).toInt();
    seconds = seconds % yearInSeconds;
    int months = (seconds / monthInSeconds).toInt();
    seconds = seconds % monthInSeconds;
    int days = (seconds / dayInSeconds).toInt();
    seconds = seconds % dayInSeconds;
    int hours = (seconds / hourInSeconds).toInt();
    seconds = seconds % hourInSeconds;
    int minutes = (seconds / minuteInSeconds).toInt();
    seconds = seconds % minuteInSeconds;

    if (years > 0) {
      return "${_count(years, "năm", "")} ${_count(months, "tháng", "")}";
    }
    if (months > 0) {
      return "${_count(months, "tháng", "")} ${_count(days, "ngày", "")} ";
    }
    if (days > 0) {
      return "${_count(days, "ngày", "")} ${_count(hours, "giờ", "")}";
    }
    if (hours > 0) {
      return "${_count(hours, "giờ", "")} ${_count(days, "ngày", "")}";
    }
    return "${_count(minutes, "phút", "")} ${_count(seconds, "giây", "")}";
  }

  static String _count(int number, String unit, String suffix) {
    if (number == 0) return "";
    if (number == 1) return "$number $unit";
    return "$number $unit$suffix";
  }
}
