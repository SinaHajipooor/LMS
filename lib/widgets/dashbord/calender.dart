import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

class PersianFullCalendar extends StatefulWidget {
  const PersianFullCalendar({Key? key}) : super(key: key);

  @override
  _PersianFullCalendarState createState() => _PersianFullCalendarState();
}

class _PersianFullCalendarState extends State<PersianFullCalendar> {
  late CalendarController _calendarController;
  String? _headerDateFormat;
  final List<Appointment> _appointments = <Appointment>[
    Appointment(
      startTime: Jalali.now().toDateTime(), // Use Jalali.now() to get the current time as a Persian solar farsi date object
      endTime: Jalali.now().toDateTime(),
      subject: 'Task 1',
      color: Colors.orange,
    ),
    Appointment(
      startTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 1))).toDateTime(), // Use Jalali.fromDateTime() to convert DateTime objects to Persian solar farsi date objects
      endTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 1))).toDateTime(),
      subject: 'Meeting',
      color: Colors.blue,
    ),
    Appointment(
      startTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 2))).toDateTime(),
      endTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 2))).toDateTime(),
      subject: 'Lunch',
      color: Colors.green,
    ),
    Appointment(
      startTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 3))).toDateTime(),
      endTime: Jalali.fromDateTime(DateTime.now().add(const Duration(days: 3))).toDateTime(),
      subject: 'Conference',
      color: Colors.purple,
    ),
  ];

  _PersianFullCalendarState() {
    final now = DateTime.now();
    final jalaliDate = Jalali.fromDateTime(now);
    _headerDateFormat = '${jalaliDate.formatter.wN}، ${jalaliDate.formatter.d} ${jalaliDate.formatter.mN} ${jalaliDate.formatter.yyyy}';
    _calendarController = CalendarController();
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    final now = DateTime.now();
    final jalaliDate = Jalali.fromDateTime(now);
    _headerDateFormat = '${jalaliDate.formatter.wN}، ${jalaliDate.formatter.d} ${jalaliDate.formatter.mN} ${jalaliDate.formatter.yyyy}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height / 1.35,
      child: SfCalendar(
        onTap: calendarOnTap,
        controller: _calendarController,
        dataSource: EventDataSource(_appointments),
        initialDisplayDate: Jalali.fromDateTime(DateTime.now()).toDateTime(),
        initialSelectedDate: Jalali.fromDateTime(DateTime.now()).toDateTime(),
        showNavigationArrow: true,
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(showAgenda: true),
        monthCellBuilder: (BuildContext context, MonthCellDetails details) {
          final jalaliDate = Jalali.fromDateTime(details.date);
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(jalaliDate.formatter.d),
              ],
            ),
          );
        },
        headerDateFormat: _headerDateFormat,
        firstDayOfWeek: DateTime.saturday,
        headerStyle: const CalendarHeaderStyle(
          textStyle: TextStyle(locale: Locale('fa'), fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onViewChanged: (viewChangedDetails) {
          final jalaliDate = Jalali.fromDateTime(_calendarController.displayDate ?? DateTime.now());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _headerDateFormat = '${jalaliDate.formatter.wN}، ${jalaliDate.formatter.d} ${jalaliDate.formatter.mN} ${jalaliDate.formatter.yyyy}';
            });
          });
        },
      ),
    );
  }

  void calendarOnTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final selectedDate = details.date!;
      final shamsiDate = Jalali.fromDateTime(selectedDate);
      // final formattedShamsiDate = '${shamsiDate.year}/${shamsiDate.month}/${shamsiDate.day}';
      setState(() {
        _headerDateFormat = '${shamsiDate.formatter.wN}، ${shamsiDate.formatter.d} ${shamsiDate.formatter.mN} ${shamsiDate.formatter.yyyy}';
      });
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

  @override
  String getLocation(int index) {
    final startTime = appointments![index].startTime!;
    final endTime = appointments![index].endTime!;
    final startJalaliDate = Jalali.fromDateTime(startTime);
    final endJalaliDate = Jalali.fromDateTime(endTime);
    final formattedStartJalaliDate = '${startJalaliDate.formatter.yyyy}/${startJalaliDate.formatter.mm}/${startJalaliDate.formatter.dd}';
    final formattedEndJalaliDate = '${endJalaliDate.formatter.yyyy}/${endJalaliDate.formatter.mm}/${endJalaliDate.formatter.dd}';
    return 'تاریخ: $formattedStartJalaliDate - $formattedEndJalaliDate';
  }
}
