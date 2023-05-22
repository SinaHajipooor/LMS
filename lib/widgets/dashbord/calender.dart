import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late List<Appointment> _appointments;

  @override
  void initState() {
    super.initState();
    // Example appointments data
    _appointments = <Appointment>[
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
      // Add more appointments with the same start and end time, but different subjects and colors
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
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        subject: 'Task 2',
        color: Colors.purple,
      ),
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        subject: 'Task 2',
        color: Colors.blue,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: SfCalendar(
        firstDayOfWeek: DateTime.saturday,
        view: CalendarView.month,
        dataSource: EventDataSource(_appointments),
        monthViewSettings: const MonthViewSettings(showAgenda: true),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {}
        },
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments?[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments?[index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments?[index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments?[index].color ?? Colors.blue;
  }
}
