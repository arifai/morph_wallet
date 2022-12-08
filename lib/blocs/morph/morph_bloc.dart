import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';

part 'morph_event.dart';
part 'morph_state.dart';

class MorphBloc extends Bloc<MorphEvent, MorphState> {
  final AccountRepository accountRepository;

  MorphBloc(this.accountRepository) : super(const MorphState()) {
    on<StartupEvent>((event, emit) async {
      emit(state.copy(status: MorphStatus.loading));

      try {
        final bool hasAccount = await accountRepository.hasAccount();

        if (hasAccount) {
          emit(state.copy(status: MorphStatus.hasAnAccount));
        } else {
          emit(state.copy(status: MorphStatus.createOrImport));
        }
      } catch (e) {
        emit(state.copy(status: MorphStatus.failure));
      }
    });
  }
}
