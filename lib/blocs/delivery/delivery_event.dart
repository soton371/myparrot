part of 'delivery_bloc.dart';

sealed class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

class FetchDeliveryMsg extends DeliveryEvent {
  const FetchDeliveryMsg({required this.deviceId});
  final String deviceId;
  @override
  List<Object> get props => [deviceId];
}