import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/app/utils/enums.dart';

part 'global_event.dart';
part 'global_state.dart';

@injectable
class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<SessionStarted>(_onSessionStarted);
    on<SessionEnded>(_onSessionEnded);
    on<SessionStatusUpdated>(_onSessionStatusUpdated);
    on<RequestStatusChanged>(_onRequestStatusChanged);
    on<ErrorOccurred>(_onErrorOccurred);
  }

  void _onAppStarted(AppStarted event, Emitter<GlobalState> emit) {
    if (event.hasSession) {
      emit(
        state.copyWith(
          hasSession: true,
          sessionStatus: SessionStatus.authenticated,
          jwtToken: event.jwtToken,
        ),
      );
    } else {
      emit(
        state.copyWith(
          hasSession: false,
          sessionStatus: SessionStatus.unauthenticated,
        ),
      );
    }
  }

  void _onSessionStarted(SessionStarted event, Emitter<GlobalState> emit) {
    emit(
      state.copyWith(
        hasSession: true,
        sessionStatus: SessionStatus.authenticated,
      ),
    );
  }

  void _onSessionEnded(SessionEnded event, Emitter<GlobalState> emit) {
    emit(
      state.copyWith(
        hasSession: false,
        sessionStatus: SessionStatus.unauthenticated,
      ),
    );
  }

  void _onSessionStatusUpdated(
    SessionStatusUpdated event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        sessionStatus: event.sessionStatus,
      ),
    );
  }

  void _onRequestStatusChanged(
    RequestStatusChanged event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<GlobalState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.errorMessage,
      ),
    );
  }
}
