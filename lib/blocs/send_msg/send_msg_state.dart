part of 'send_msg_bloc.dart';

sealed class SendMsgState extends Equatable {
  const SendMsgState();
  
  @override
  List<Object> get props => [];
}

final class SendMsgInitial extends SendMsgState {}
