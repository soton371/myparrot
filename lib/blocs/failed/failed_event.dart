part of 'failed_bloc.dart';

sealed class FailedEvent extends Equatable {
  const FailedEvent();

  @override
  List<Object> get props => [];
}
class FetchFailedMsg extends FailedEvent {
  const FetchFailedMsg({required this.deviceId});
  final String deviceId;
  @override
  List<Object> get props => [deviceId];
}