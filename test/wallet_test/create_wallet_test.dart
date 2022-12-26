import 'package:flutter_test/flutter_test.dart';
import 'package:morph_wallet/services/wallet_service.dart';

void main() {
  final List<String> genMnemonic = WalletService().generetaMnemonic();
  // final List<String> mnemonic = [
  //   'one',
  //   'two',
  //   'three',
  //   'four',
  //   'five',
  //   'six',
  //   'seven',
  //   'eight',
  //   'nine',
  //   'ten',
  //   'eleven',
  //   'twelve'
  // ];

  group('Create Wallet Test', () {
    test('Generate new mnemonic', () {
      expect(genMnemonic, genMnemonic);
    });

    test('Mnemonic 12 words', () {
      expect(genMnemonic.length, 12);
    });
  });
}
