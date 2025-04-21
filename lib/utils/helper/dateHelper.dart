import 'package:intl/intl.dart';

class DateHelper {

  static const _locale = 'en';

  static const int secondMillis = 1000;
  static const int minuteMillis = 60 * secondMillis;
  static const int hourMillis = 60 * minuteMillis;
  static const int dayMillis = 24 * hourMillis;

  static const _isoFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static final _isoFormatter = DateFormat(_isoFormat);

  static final _timeFormat12 = DateFormat("h:mm a");
  static final _timeFormat24 = DateFormat("HH:mm:ss");
  static final _dfPreferenceTime = DateFormat("HH:mm", _locale);
  static final _dfDBPreferenceTime = DateFormat("HH:mm", _locale);

  static final _addCardDateFormat = DateFormat("MM/yyyy", _locale);
  static final _dateFormat = DateFormat("MMM dd, yyyy", _locale);
  static final _dateFormatSimple = DateFormat("dd/MM/yyyy", _locale);
  static final _dateFormat1 = DateFormat("yyyy-MM-dd", _locale);
  static final _dfPreferenceDate = DateFormat("dd-MM-yyyy", _locale);
  static final _dfDBPreferenceDate = DateFormat("yyyy-MM-dd", _locale);
  static final _dfViewPreferenceDate = DateFormat("dd MMM yyyy", _locale);


  static DateTime getUtcTime(String? dateTimeString){
    return _isoFormatter.parse(dateTimeString!, true);
  }

  static DateTime getAddCardDate(String date) {
    return _addCardDateFormat.parse(date);
  }

  static DateTime getPrefTimeIntoDate(String date) {
    return _dfDBPreferenceTime.parse(date);
  }

  static String getCardDate(DateTime? date) {
    if (date == null) return "";
    return _addCardDateFormat.format(date);
  }

  static String getDate(String? date) {
    if (date == null) return "";
    return _dateFormat.format(getUtcTime(date));
  }

  static String getDateSimple(String? date) {
    if (date == null) return "";
    return _dateFormatSimple.format(getUtcTime(date));
  }

  static String getDate1(String? date) {
    if (date == null) return "";
    return _dateFormat1.format(getUtcTime(date));
  }

  static String formatPreferenceDate(DateTime? date) {
    if (date == null) return "";
    return _dfPreferenceDate.format(date);
  }

  static String formatPreferenceTime(DateTime? date) {
    if (date == null) return "";
    return _dfPreferenceTime.format(date);
  }

  static String formatDBPreferenceTime(DateTime? date) {
    if (date == null) return "";
    return _dfDBPreferenceTime.format(date);
  }

  static String formatDBPreferenceDate(DateTime? date) {
    if (date == null) return "";
    return _dfDBPreferenceDate.format(date);
  }


  static String timeAgo(DateTime d) {
    // String time = _epochDate.format(d);
    // DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
    Duration diff = DateTime.now().difference(d);
    //DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  String convertToTimeAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    Duration timeDifference = DateTime.now().difference(dateTime);

    if (timeDifference.inSeconds < 60) {
      if(timeDifference.inSeconds == 0){
        return 'now';
      }else{
        return '${timeDifference.inSeconds} sec';
      }
    } else if (timeDifference.inMinutes < 60) {
      return '${timeDifference.inMinutes} min';
    } else if (timeDifference.inHours < 24) {
      return '${timeDifference.inHours} h';
    } else if (timeDifference.inDays < 30) {
      return '${timeDifference.inDays} days';
    }else if (timeDifference.inDays < 365) {
      return '${(timeDifference.inDays / 30).floor()}m';
    }
    else {
      return '${(timeDifference.inDays / 365).floor()}y';
    }
  }

  static String preferenceDateView(String? input) {
    return _dfViewPreferenceDate.format(getUtcTime(input));
  }

  static DateTime? dateTime(int? dayOfMonth, int? month, int? year) {
    DateTime now = DateTime.now();
    DateTime output = DateTime(year ?? now.year, month ?? now.month, dayOfMonth ?? now.day);
    return output;
  }

  static String formatDateTime(DateTime selectedDate, String format) {
    final sdf = DateFormat(format, _locale);
    return sdf.format(selectedDate);
  }
}
