part of 'failed_bloc.dart';

sealed class FailedState extends Equatable {
  const FailedState();
  
  @override
  List<Object> get props => [];
}

final class FailedInitial extends FailedState {}

final class FailedFetchLoading extends FailedState {}

final class FailedFetched extends FailedState {
  const FailedFetched({required this.failedMsgList});
  final List<Datum> failedMsgList;
  @override
  List<Object> get props => [failedMsgList];
}

final class FailedFetchFailed extends FailedState {
  const FailedFetchFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}