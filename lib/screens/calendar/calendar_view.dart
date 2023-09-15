import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myparrot/models/calendar_mod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.calendarCounterList});
  final List<Counter> calendarCounterList;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final DateTime _focusedDay = DateTime.now();
  DateTime kFirstDay = DateTime.now().subtract(const Duration(days: 60));
  DateTime kToday = DateTime.now();
  DateTime kLastDay = DateTime.now();

  List<Counter> calendarCountList = [];
  @override
  void initState() {
    super.initState();
    calendarCountList = widget.calendarCounterList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          /*
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, day) {
              String generateDate = "${myDay(date)}-${day.month}-${day.year}";
              var msgCounts = calendarCountList
                  .where((element) => element.date == generateDate);
              for (var sss in msgCounts) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.seed)),
                  child: Text(date.day.toString()),
                );
              }
              return null;
            },
            defaultBuilder: (context, date, day) {
              String generateDate = "${myDay(date)}-${day.month}-${day.year}";
              var msgCounts = calendarCountList
                  .where((element) => element.date == generateDate);
              for (var sss in msgCounts) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.disable)),
                  child: Text(date.day.toString()),
                );
              }
              return null;
            },
            markerBuilder: (context, day, event) {
                          String generateDate = "${myDay(day)}-${day.month}-${day.year}";
              var msgCounts = calendarCountList
                  .where((element) => element.date == generateDate);
                          for (var sss in msgCounts) {
                            if (sss.date == generateDate) {
                              return sss.pendingCount == '0'
                                  ? const SizedBox()
                                  : Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                      margin: const EdgeInsets.only(left: 40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: MyColors.dismiss,
                                      ),
                                      child: Text(
                                        "${sss.pendingCount}",
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    );
                            } else {
                              return const SizedBox();
                            }
                          }
                          return null;
                        },
          ),
          */
        ),
        const Text(" calendar data")
      ],
    );
  }
}
