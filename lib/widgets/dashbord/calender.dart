import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FullCalendar extends StatefulWidget {
  const FullCalendar({super.key});

  @override
  State<FullCalendar> createState() => _FullCalendarState();
}

class _FullCalendarState extends State<FullCalendar> {
  //----------------- state ----------------------
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime(1990),
      lastDay: DateTime(2050),
      calendarFormat: format,
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
        });
      },
      onFormatChanged: (CalendarFormat _format) {
        setState(() {
          format = _format;
        });
      },
      startingDayOfWeek: StartingDayOfWeek.saturday,
      daysOfWeekVisible: true,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue[100],
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
      selectedDayPredicate: (DateTime date) {
        return isSameDay(selectedDay, date);
      },
      headerStyle: HeaderStyle(
        formatButtonShowsNext: true,
        formatButtonDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        // leftChevronVisible: false,
        // rightChevronVisible: false,
        // headerPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      ),
    );
  }
}
