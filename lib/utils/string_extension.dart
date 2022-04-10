import 'package:intl/intl.dart';

extension ToIdr on String {
  String toIdr() {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return currencyFormatter.format(double.parse(this));
  }
}
