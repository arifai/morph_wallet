part of 'wallet_account_bloc.dart';

enum WalletAccountStatus { initial, loading, loaded }

class WalletAccountState extends Equatable {
  final WalletAccountStatus status;
  final String? address;
  final int balance;

  const WalletAccountState({
    this.status = WalletAccountStatus.initial,
    this.address,
    this.balance = 0,
  });

  WalletAccountState copy(
      {WalletAccountStatus? status, String? address, int? balance}) {
    return WalletAccountState(
      status: status ?? this.status,
      address: address ?? this.address,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [status, address, balance];
}
