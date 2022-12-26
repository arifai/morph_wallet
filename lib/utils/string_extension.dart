import 'package:intl/intl.dart';
import 'package:solana/solana.dart';

extension ToIdr on String {
  String toIdr() {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return currencyFormatter.format(double.parse(this));
  }
}

extension Crypto on String {
  String toSol() {
    final double result = double.parse(this) / lamportsPerSol;

    return '$result';
  }
}
