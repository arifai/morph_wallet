import 'package:bloc/bloc.dart';
import 'package:morph_wallet/blocs/morph/morph_event.dart';
import 'package:morph_wallet/blocs/morph/morph_state.dart';

class MorphBloc extends Bloc<MorphEvent, MorpthState> {
  static MorpthState get initialState => AppInitial();

  MorphBloc() : super(initialState) {
    on<StartupEvent>((event, emit) => emit(AuthenticationLoading()));
  }
}
