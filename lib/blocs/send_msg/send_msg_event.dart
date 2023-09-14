part of 'send_msg_bloc.dart';

sealed class SendMsgEvent extends Equatable {
  const SendMsgEvent();

  @override
  List<Object> get props => [];
}

class DoSendMsg extends SendMsgEvent {
  const DoSendMsg(
      {required this.deviceId,
      required this.message,
      required this.name,
      required this.phones,
      required this.scheduledAt});
  final String deviceId, message, scheduledAt, phones, name;
  @override
  List<Object> get props => [deviceId, message, scheduledAt, phones, name];
}
