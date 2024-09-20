part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends GlobalEvent {
  const AppStarted({required this.hasSession, this.jwtToken});

  final bool hasSession;
  final String? jwtToken;
}

class SessionStarted extends GlobalEvent {
  const SessionStarted();
}

class SessionEnded extends GlobalEvent {
  const SessionEnded();
}

class SessionStatusUpdated extends GlobalEvent {
  const SessionStatusUpdated(this.sessionStatus);

  final SessionStatus sessionStatus;

  @override
  List<Object?> get props => [sessionStatus];
}

class RequestStatusChanged extends GlobalEvent {
  const RequestStatusChanged(this.status);

  final RequestStatus status;

  @override
  List<Object?> get props => [status];
}

class ErrorOccurred extends GlobalEvent {
  const ErrorOccurred(this.errorMessage);
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
