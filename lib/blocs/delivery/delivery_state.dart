part of 'delivery_bloc.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryInitial extends DeliveryState {}

final class DeliveryFetchLoading extends DeliveryState {}

final class DeliveryFetched extends DeliveryState {
  const DeliveryFetched({required this.deliveryMsgList});
  final List<Datum> deliveryMsgList;
  @override
  List<Object> get props => [deliveryMsgList];
}

final class DeliveryFetchFailed extends DeliveryState {
  const DeliveryFetchFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}
