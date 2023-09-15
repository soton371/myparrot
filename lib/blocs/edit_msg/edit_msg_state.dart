part of 'edit_msg_bloc.dart';

sealed class EditMsgState extends Equatable {
  const EditMsgState();
  
  @override
  List<Object> get props => [];
}

final class EditMsgInitial extends EditMsgState {}


final class EditMsgSuccess extends EditMsgState {}

final class EditMsgFailed extends EditMsgState {
  const EditMsgFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}

final class EditMsgLoading extends EditMsgState {}
