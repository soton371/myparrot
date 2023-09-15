part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

final class CalendarInitial extends CalendarState {}

final class CalendarFetchLoading extends CalendarState {}

final class CalendarFetched extends CalendarState {
  const CalendarFetched({required this.calendarCountList});
  final List<Counter> calendarCountList;
  @override
  List<Object> get props => [calendarCountList];
}

final class CalendarFetchFailed extends CalendarState {
  const CalendarFetchFailed({required this.errorMsg});
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
}
