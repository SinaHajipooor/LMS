import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:jdate/jdate.dart';

class PersianFullCalendar extends StatefulWidget {
  const PersianFullCalendar({super.key});

  @override
  _PersianFullCalendarState createState() => _PersianFullCalendarState();
}

class _PersianFullCalendarState extends State<PersianFullCalendar> {
  late CalendarController _calendarController;
  List<Appointment> _appointments = <Appointment>[
    Appointment(
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1)),
      subject: 'Meeting',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 2)),
      subject: 'Lunch',
      color: Colors.green,
    ),
    Appointment(
      startTime: DateTime.now().add(const Duration(days: 3)),
      endTime: DateTime.now().add(const Duration(days: 3)),
      subject: 'Conference',
      color: Colors.purple,
    ),
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      subject: 'Task 1',
      color: Colors.orange,
    ),
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      subject: 'Task 2',
      color: Colors.red,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  // Function to convert the Gregorian date to Persian (Solar) date
  String formatDate(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final String formattedDate = '${jalali.year}/${jalali.month}/${jalali.day}';
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Jalali jalaliDate = Jalali.fromDateTime(now);
    String formattedDate = '${jalaliDate.formatter.mN} ${jalaliDate.formatter.yyyy}';
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height / 1.35,
      child: SfCalendar(
        onTap: calendarOnTap,
        controller: _calendarController,
        dataSource: EventDataSource(_appointments),
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(showAgenda: true),
        headerDateFormat: formattedDate,
        firstDayOfWeek: DateTime.saturday,
        headerStyle: const CalendarHeaderStyle(
          textStyle: TextStyle(locale: Locale('fa'), fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void calendarOnTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final selectedDate = details.date!;
      final shamsiDate = Jalali.fromDateTime(selectedDate);
      final formattedShamsiDate = '${shamsiDate.year}/${shamsiDate.month}/${shamsiDate.day}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            "تاریخ انتخاب شده: $formattedShamsiDate",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject!;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime!;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime!;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color ?? Colors.blue;
  }
}
