part of 'radio_bloc.dart';

sealed class RadioEvent extends Equatable {
  const RadioEvent();

  @override
  List<Object> get props => [];
}

class RadioChangedEvent extends RadioEvent {
  final Auth auth;

  const RadioChangedEvent({required this.auth});

  @override
  List<Object> get props => [auth];
}
