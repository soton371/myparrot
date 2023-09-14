part of 'delete_msg_bloc.dart';

sealed class DeleteMsgEvent extends Equatable {
  const DeleteMsgEvent();

  @override
  List<Object> get props => [];
}

class DoDeleteMsg extends DeleteMsgEvent {
  const DoDeleteMsg(
      {required this.msgId});
  final String msgId;
  @override
  List<Object> get props => [msgId];
}