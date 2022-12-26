import 'package:equatable/equatable.dart';
import 'package:morph_wallet/models/wallet_account/keypair.dart';
import 'package:solana/solana.dart';

class WalletAccount extends Equatable {
  final String name;
  final String password;
  final Wallet? wallet;
  final Keypair? keypair;

  const WalletAccount(this.name, this.password, {this.wallet, this.keypair});

  String? get address => wallet?.address;
  Ed25519HDPublicKey? get publicKey => wallet?.publicKey;

  Map<String, dynamic> toMap() => {
        'name': name,
        'keypair': keypair?.toMap(),
        'password': password,
      };

  @override
  List<Object?> get props => [name, password, wallet, keypair];
}
