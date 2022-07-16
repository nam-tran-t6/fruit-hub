import 'package:intl/intl.dart';

extension NumX on num {
  String toCurrencyFormat() {
    var format = NumberFormat('###,###');
    return format.format(this);
  }
}
