part of 'wallet_account_bloc.dart';

enum WalletAccountStatus { initial, loading, loaded }

class WalletAccountState extends Equatable {
  final WalletAccountStatus status;

  const WalletAccountState({this.status = WalletAccountStatus.initial});

  WalletAccountState copy({WalletAccountStatus? status}) {
    return WalletAccountState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
