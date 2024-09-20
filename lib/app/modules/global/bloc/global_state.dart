part of 'global_bloc.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

class GlobalState extends Equatable {
  const GlobalState({
    this.hasSession = false,
    this.sessionStatus = SessionStatus.unknown,
    this.status = RequestStatus.unknown,
    this.errorMessage = '',
    this.jwtToken = '',
  });

  factory GlobalState.initial() {
    return const GlobalState();
  }

  final bool hasSession;
  final SessionStatus sessionStatus;
  final RequestStatus status;
  final String errorMessage;
  final String jwtToken;

  GlobalState copyWith({
    bool? hasSession,
    SessionStatus? sessionStatus,
    RequestStatus? status,
    String? errorMessage,
    String? jwtToken,
  }) {
    return GlobalState(
      hasSession: hasSession ?? this.hasSession,
      sessionStatus: sessionStatus ?? this.sessionStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      jwtToken: jwtToken ?? this.jwtToken,
    );
  }

  @override
  List<Object> get props => [
        hasSession,
        sessionStatus,
        status,
        errorMessage,
        jwtToken,
      ];
}
