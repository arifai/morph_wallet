part of 'create_wallet_bloc.dart';

enum CreateWalletStatus { initial, loading, success, failure }

class CreateWalletState extends Equatable {
  final CreateWalletStatus status;
  final String? message;

  const CreateWalletState({
    this.status = CreateWalletStatus.initial,
    this.message,
  });

  CreateWalletState copy({CreateWalletStatus? status, String? message}) {
    return CreateWalletState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
