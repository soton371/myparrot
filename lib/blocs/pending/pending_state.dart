part of 'pending_bloc.dart';

sealed class PendingState extends Equatable {
  const PendingState();

  @override
  List<Object> get props => [];
}

final class PendingInitial extends PendingState {}

final class PendingFetchLoading extends PendingState {}

final class PendingFetched extends PendingState {
  const PendingFetched({required this.pendingMsgList});
  final List<Datum> pendingMsgList;
  @override
  List<Object> get props => [pendingMsgList];
}

final class PendingFetchFailed extends PendingState {
  const PendingFetchFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}
