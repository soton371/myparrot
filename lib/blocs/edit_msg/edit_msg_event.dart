part of 'edit_msg_bloc.dart';

sealed class EditMsgEvent extends Equatable {
  const EditMsgEvent();

  @override
  List<Object> get props => [];
}

class DoEditMsg extends EditMsgEvent {
  const DoEditMsg(
      {required this.msgId,
      required this.message,
      required this.name,
      required this.phones,
      required this.scheduledAt});
  final String msgId, message, scheduledAt, phones, name;
  @override
  List<Object> get props => [msgId, message, scheduledAt, phones, name];
}