import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toDateFormat() {
    var formatter = DateFormat.yMd().add_Hms();
    return formatter.format(this);
  }
}