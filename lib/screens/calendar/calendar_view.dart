import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/blocs/pending/pending_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/calendar_mod.dart';
import 'package:myparrot/models/pending_msg_mod.dart';
import 'package:myparrot/screens/summary/components/failed/failed_list_tile.dart';
import 'package:myparrot/screens/summary/components/pending/pending_list_tile.dart';
import 'package:myparrot/utilities/filter_pending_msg.dart';
import 'package:myparrot/utilities/my_day.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.calendarCounterList});
  final List<Counter> calendarCounterList;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime kFirstDay = DateTime.now();
  DateTime kToday = DateTime.now();
  DateTime kLastDay = DateTime.now().add(const Duration(days: 60));
  DateTime? _selectedDay;

  List<Counter> calendarCountList = [];
  Counter? msgCounter;
  List<Datum> pendingMsgList = [];

  @override
  void initState() {
    super.initState();
    calendarCountList = widget.calendarCounterList;
    _selectedDay = _focusedDay;
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    context
        .read<PendingBloc>()
        .add(FetchPendingMsg(deviceId: identifierBloc.identifier));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          startingDayOfWeek: StartingDayOfWeek.saturday,
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, day) {
              String generateDate =
                  "${myDay(date)}-${myMonth(date)}-${day.year}";
              var pendingList = calendarCountList
                  .where((element) => element.date == generateDate);
              for (var sss in pendingList) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: sss.pendingCount == '0'
                              ? MyColors.seed
                              : MyColors.amber)),
                  child: Text(date.day.toString()),
                );
              }
              return null;
            },
            defaultBuilder: (context, date, day) {
              String generateDate =
                  "${myDay(date)}-${myMonth(date)}-${day.year}";
              var pending = calendarCountList
                  .where((element) => element.date == generateDate);

              for (var sss in pending) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: sss.pendingCount == '0'
                              ? MyColors.seed
                              : MyColors.amber)),
                  child: Text(date.day.toString()),
                );
              }
              return null;
            },
            markerBuilder: (context, day, event) {
              String generateDate = "${myDay(day)}-${myMonth(day)}-${day.year}";
              debugPrint("generateDate defaultBuilder: $generateDate");
              var pending = calendarCountList
                  .where((element) => element.date == generateDate);
              for (var sss in pending) {
                if (sss.date == generateDate) {
                  return sss.pendingCount == '0'
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: sss.pendingCount == '0'
                                ? MyColors.seed
                                : MyColors.amber,
                          ),
                          child: Text(
                            "${sss.pendingCount}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                } else {
                  return const SizedBox();
                }
              }
              return null;
            },
          ),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                var dt = DateFormat('dd-MM-yyyy').format(selectedDay);
                final pendingBloc = BlocProvider.of<PendingBloc>(context);
                debugPrint("pendingBloc.pendingMsgList: ${pendingBloc.pendingMsgList.length}");
                pendingMsgList =
                    filterPendingMsg(dt, pendingBloc.pendingMsgList);
                var selectedDayMsgCount1 =
                    calendarCountList.where((element) => element.date == dt);
                if (selectedDayMsgCount1.isNotEmpty) {
                  msgCounter = selectedDayMsgCount1.first;
                }
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          enabledDayPredicate: (day) {
            String generateDate = "${myDay(day)}-${myMonth(day)}-${day.year}";
            var pending = calendarCountList
                .where((element) => element.date == generateDate);
            bool isFound = false;
            for (var sss in pending) {
              if (sss.date == generateDate) {
                isFound = true;
                break;
              }
            }
            return isFound;
          },
        ),
        Expanded(
            child: ListView.builder(
                itemCount: pendingMsgList.length,
                itemBuilder: (context, index) {
                  var data = pendingMsgList[index];
                  return PendingListTile(pendingMsg: data);
                })),
      ],
    );
  }
}
