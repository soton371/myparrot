part of 'send_msg_bloc.dart';

sealed class SendMsgState extends Equatable {
  const SendMsgState();

  @override
  List<Object> get props => [];
}

final class SendMsgInitial extends SendMsgState {}

final class SendMsgSuccess extends SendMsgState {}

final class SendMsgFailed extends SendMsgState {
  const SendMsgFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}

final class SendMsgLoading extends SendMsgState {}
