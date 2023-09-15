part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class FetchCalendarData extends CalendarEvent {
  const FetchCalendarData({required this.deviceId});
  final String deviceId;
  @override
  List<Object> get props => [deviceId];
}