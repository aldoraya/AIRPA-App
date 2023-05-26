import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(num value) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
    );
    return currencyFormatter.format(value);
  }
}