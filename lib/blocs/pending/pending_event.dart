part of 'pending_bloc.dart';

sealed class PendingEvent extends Equatable {
  const PendingEvent();

  @override
  List<Object> get props => [];
}

class FetchPendingMsg extends PendingEvent {
  const FetchPendingMsg({required this.deviceId});
  final String deviceId;
  @override
  List<Object> get props => [deviceId];
}