part of 'delete_msg_bloc.dart';

sealed class DeleteMsgState extends Equatable {
  const DeleteMsgState();
  
  @override
  List<Object> get props => [];
}

final class DeleteMsgInitial extends DeleteMsgState {}

final class DeleteMsgSuccess extends DeleteMsgState {}

final class DeleteMsgFailed extends DeleteMsgState {
  const DeleteMsgFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}

final class DeleteMsgLoading extends DeleteMsgState {}

