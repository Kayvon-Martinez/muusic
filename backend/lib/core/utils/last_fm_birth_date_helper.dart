import 'package:backend/core/values/regex_patterns.dart';

int _monthToNumber(String month) {
  switch (month.toLowerCase()) {
    case "january" || "jan":
      return 1;
    case "february" || "feb":
      return 2;
    case "march" || "mar":
      return 3;
    case "april" || "apr":
      return 4;
    case "may":
      return 5;
    case "june" || "jun":
      return 6;
    case "july" || "jul":
      return 7;
    case "august" || "aug":
      return 8;
    case "september" || "sep":
      return 9;
    case "october" || "oct":
      return 10;
    case "november" || "nov":
      return 11;
    case "december" || "dec":
      return 12;
    default:
      return 0;
  }
}

DateTime? lastFMBirthDateToDateTime(String lastFMBirthDate) {
  if (lastFMBirthDate == "Unknown") {
    return null;
  }
  var dateMatch = birthDateRegExp.firstMatch(lastFMBirthDate);
  if (dateMatch == null) {
    return null;
  }
  var day = int.tryParse(dateMatch.group(1) ?? "0");
  var month = dateMatch.group(2);
  var year = int.tryParse(dateMatch.group(3) ?? "0");
  if (day == null || month == null || year == null) {
    return null;
  }
  var monthNumber = _monthToNumber(month);
  if (monthNumber == 0) {
    return null;
  }
  return DateTime(year, monthNumber, day);
}
