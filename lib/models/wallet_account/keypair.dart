import 'package:equatable/equatable.dart';

class Keypair extends Equatable {
  final String? mnemonic;
  final int account;
  final int change;

  const Keypair(this.mnemonic, this.account, this.change);

  Map<String, dynamic> toMap() =>
      {'mnemonic': mnemonic, 'account': account, 'change': change};

  @override
  List<Object?> get props => [mnemonic, account, change];
}
