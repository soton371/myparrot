import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:myparrot/models/calendar_mod.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<FetchCalendarData>((event, emit) async{
      debugPrint("call FetchCalendarData");
      emit(CalendarFetchLoading());
      try {
        Uri url = Uri.parse("${MyUrls.calender}/${event.deviceId}");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final calendarModel = calendarModelFromJson(response.body);
          final data = calendarModel.counter;
          if (data != null && data.isNotEmpty) {
            final List<Counter> calendarCountList = data;
            emit(CalendarFetched(calendarCountList: calendarCountList));
          } else {
            emit(
                const CalendarFetchFailed(errorMsg: "There is no data in the calendar"));
          }
        } else {
          emit(const CalendarFetchFailed(errorMsg: "Internal server error"));
        }
      } on TimeoutException catch (e) {
        debugPrint("TimeoutException: $e");
        emit(const CalendarFetchFailed(errorMsg: "Timeout please try again"));
      } on SocketException catch (e) {
        debugPrint("SocketException: $e");
        emit(const CalendarFetchFailed(
            errorMsg: "Please check your internet connection"));
      } catch (e) {
        emit(const CalendarFetchFailed(errorMsg: "Something went wrong"));
      }
    });
  }
}
