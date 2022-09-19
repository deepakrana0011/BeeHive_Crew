import 'package:easy_localization/easy_localization.dart';

class DateFunctions {
  /* static String dateFormatddmmyyy(DateTime now) {
    String formattedDate = DateFormat("MM/dd/yyyy", localeCode).format(now);
    return formattedDate;
  }

  static String dateFormatyyyymmdd(DateTime now) {
    String formattedDate = DateFormat("yyyy-MM-dd", localeCode).format(now);
    return formattedDate;
  }

  static String dateFormatEEEMMMD(DateTime dateTime) {
    String formattedDate = DateFormat("EEE MMM d", localeCode).format(dateTime);
    return formattedDate;
  }

  static String dateFormatEEEMMMDWIthComma(DateTime dateTime) {
    String formattedDate =
        DateFormat("EEE, MMM d", localeCode).format(dateTime);
    return formattedDate;
  }

  static String convertToEEEMMMDWithComma(String dateTime) {
    DateTime date =
        new DateFormat("yyyy-MM-dd hh:mm:ss", localeCode).parse(dateTime);
    String formattedDate = DateFormat("EEE, MMM d", localeCode).format(date);
    return formattedDate;
  }

  static String convertTohhmmaaWithComma(String dateTime) {
    DateTime date =
        new DateFormat("yyyy-MM-dd h:mm:ss", localeCode).parse(dateTime);
    String formattedDate = DateFormat("h:mm a", localeCode).format(date);
    return formattedDate.toLowerCase();
  }

  static String formatFromyyyymmddToddmmyyyy(String dateString) {
    if (dateString == "") return "";
    DateTime date = new DateFormat("yyyy/MM/dd", localeCode).parse(dateString);
    String formattedDate = DateFormat("MM/dd/yyyy", localeCode).format(date);
    return formattedDate;
  }

  static String formatFromddmmyyyyToyyyymmdd(String dateString) {
    if (dateString == "") return "";
    DateTime date = new DateFormat("MM/dd/yyyy", localeCode).parse(dateString);
    String formattedDate = DateFormat("yyyy/MM/dd").format(date);
    return formattedDate;
  }

  static DateTime getDateTimeFromString(String date) {
    DateTime dateTime = new DateFormat("yyyy/MM/dd", localeCode).parse(date);
    return dateTime;
  }

  static DateTime getDateTimeFromStringMMddyyyyhhmmaa(String date) {
    DateTime dateTime =
        new DateFormat("MM/dd/yyyy h:mm a", localeCode).parse(date);
    return dateTime;
  }

  static DateTime getDateTimeHHmmFromString(String date) {
    DateTime dateTime = new DateFormat("HH:mm", localeCode).parse(date);
    return dateTime;
  }

  static String getCurrentDayName(int value) {
    DateTime date = DateTime.now().add(Duration(days: value));
    String dayName = DateFormat("EEEE", localeCode).format(date);
    return dayName.toUpperCase();
  }

  static String getCurrentDayNameInSmall() {
    DateTime date = DateTime.now();
    String dayName = DateFormat("EEE", localeCode).format(date);
    return dayName;
  }

  static DateTime getCurrentTimeInHHmm() {
    DateTime date = DateTime.now();
    String time = DateFormat("HH:mm", localeCode).format(date);
    DateTime new24HourFormat = new DateFormat("HH:mm", localeCode).parse(time);
    return new24HourFormat;
  }

  static String getCurrentDateMonth() {
    DateTime date = DateTime.now();
    String dayName = DateFormat("dd MM", localeCode).format(date);
    return dayName.toUpperCase();
  }

  static String getCurrentDateMonthYear() {
    DateTime date = DateTime.now();
    String dayName = DateFormat("dd/MM/yyy", localeCode).format(date);
    return dayName.toUpperCase();
  }

  static String amPmTime(String dateString) {
    if (dateString == "") return "";
    DateTime date = new DateFormat("HH:mm", localeCode).parse(dateString);
    String newTime = DateFormat("h:mm a", localeCode).format(date);
    return newTime.toLowerCase();
  }

  static DateTime amPmTo24Time(DateTime dateString) {
    String newTime = DateFormat("HH:mm", localeCode).format(dateString);
    DateTime new24HourFormat =
        new DateFormat("HH:mm", localeCode).parse(newTime);
    return new24HourFormat;
  }

  static bool isTimeAfterCurrentTime(String dateString) {
    if (dateString == "") return false;
    DateTime date = new DateFormat("HH:mm", localeCode).parse(dateString);
    var currentTimeString =
        DateFormat("HH:mm", localeCode).format(DateTime.now());
    DateTime currentTimeDate =
        new DateFormat("HH:mm", localeCode).parse(currentTimeString);
    var value = date.isAfter(currentTimeDate);
    return value;
  }

  static bool isTimeBeforeCurrentTime(String dateString) {
    if (dateString == "") return false;
    DateTime date = new DateFormat("HH:mm", localeCode).parse(dateString);
    var currentTimeString =
        DateFormat("HH:mm", localeCode).format(DateTime.now());
    DateTime currentTimeDate =
        new DateFormat("HH:mm", localeCode).parse(currentTimeString);
    var value = date.isBefore(currentTimeDate);
    return value;
  }

  static bool is24TimeBeforeCurrentTime(DateTime date) {
    var currentTimeString =
        DateFormat("HH:mm", localeCode).format(DateTime.now());
    DateTime currentTimeDate =
        new DateFormat("HH:mm", localeCode).parse(currentTimeString);
    var value = date.isBefore(currentTimeDate);
    return value;
  }

  static bool is24TimeAfterCurrentTime(DateTime date) {
    var currentTimeString =
        DateFormat("HH:mm", localeCode).format(DateTime.now());
    DateTime currentTimeDate =
        new DateFormat("HH:mm", localeCode).parse(currentTimeString);
    var value = date.isAfter(currentTimeDate);
    return value;
  }

  static String addMintuesToTime(String dateString, int minutes) {
    DateTime date = new DateFormat("h:mm a", localeCode).parse(dateString);
    DateTime newTimeAddedDate = date.add(Duration(minutes: minutes));
    String newTime = DateFormat("h:mm a", localeCode).format(newTimeAddedDate);
    return newTime;
  }

  static String getDayName(DateTime dateTime) {
    String dayName = DateFormat("EEEE", localeCode).format(dateTime);
    return dayName.toUpperCase();
  }

  static String getDayNameSmall(DateTime dateTime) {
    String dayName = DateFormat("EEE", localeCode).format(dateTime);
    return dayName;
  }

  static String getDateMonth(DateTime dateTime) {
    String dayName = DateFormat("dd MM", localeCode).format(dateTime);
    return dayName.toUpperCase();
  }

  static String getTime(DateTime dateTime) {
    String dayTime = DateFormat("h:mm a", localeCode).format(dateTime);
    return dayTime.toLowerCase();
  }

  static String getTimeWithSec(DateTime dateTime) {
    String dayTime = DateFormat("hh:mm:ss a", localeCode).format(dateTime);
    return dayTime;
  }

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    var value = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    if (value.contains("00:")) {
      value = value.substring(value.indexOf(":") + 1, value.length) + " min";
    } else {
      value = value + " hour";
    }
    var newValue = value.substring(0, 1);
    if (newValue == "0") {
      value = value.substring(1, value.length);
    }
    return value;
  }

  static String dateFormatMMMddYYYY(DateTime dateTime) {
    String dayName = DateFormat("MMM dd, yyyy", localeCode).format(dateTime);
    return dayName;
  }

  static String amPmTimeFromDateTime(DateTime dateTime) {
    String newTime = DateFormat("h:mm a", localeCode).format(dateTime);
    return newTime.toLowerCase();
  }

  static String getMMMDDFromTimeStamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    var dateString = new DateFormat("MMMM d'$suffix'", localeCode).format(date);
    */ /*var valueString =
        new DateFormat("h:mm a", localeCode).format(date).toLowerCase();*/ /*
    return dateString */ /*+ ", " + valueString*/ /*;
  }*/

  static DateTime stringToDate(String dateString) {
    DateTime date = DateFormat("hh:mm a").parse(dateString);
    String _24HourFormat = DateFormat("HH:mm").format(date);
    DateTime _24HourFormatDate = DateFormat("hh:mm").parse(_24HourFormat);
    return _24HourFormatDate;
  }
}
