part of 'morph_bloc.dart';

enum MorphStatus { initial, loading, createOrImport, hasAnAccount, failure }

class MorphState extends Equatable {
  final MorphStatus status;
  final String? message;

  const MorphState({this.status = MorphStatus.initial, this.message});

  MorphState copy({MorphStatus? status, String? message}) {
    return MorphState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
