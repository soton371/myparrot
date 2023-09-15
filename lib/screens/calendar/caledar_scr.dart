import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/calendar/calendar_bloc.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/screens/calendar/calendar_view.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    context.read<CalendarBloc>().add(FetchCalendarData(deviceId: identifierBloc.identifier));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calender"),
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
        if (state is CalendarFetchLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is CalendarFetched) {
          return CalendarView(calendarCounterList: state.calendarCountList);
        } else if (state is CalendarFetchFailed) {
          return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/calendar.png",
                  height: MySizes.emptyIcon, width: MySizes.emptyIcon),
               Text("\n${state.errorMsg}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: MyColors.disable)),
            ],
          ),
        );
        } else {
          return const Center(
            child: Text(
              "Init",
              style: TextStyle(color: MyColors.disable),
            ),
          );
        }
      }),
    );
  }
}
