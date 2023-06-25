import 'package:flutter/material.dart';
import 'package:lms/widgets/dashbord/calendar_modal.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PersianFullCalendar extends StatefulWidget {
  // 1 for student 2 for teacher
  final int calendarUsecase;
  const PersianFullCalendar({super.key, required this.calendarUsecase});
  @override
  // ignore: library_private_types_in_public_api
  _PersianFullCalendarState createState() => _PersianFullCalendarState();
}

class _PersianFullCalendarState extends State<PersianFullCalendar> {
  late CalendarController _calendarController;
  String? _headerDateFormat;
  final ScrollController _scrollController = ScrollController();

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
    return Card(
      elevation: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height / 2,
        child: SfCalendar(
          onTap: calendarOnTap,
          controller: _calendarController,
          initialDisplayDate: Jalali.now().toDateTime(),
          dataSource: EventDataSource(_appointments),
          initialSelectedDate: Jalali.now().toDateTime(),
          showNavigationArrow: true,
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(showAgenda: false),
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
      ),
    );
  }

  void calendarOnTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final selectedDate = details.date!;
      final shamsiDate = Jalali.fromDateTime(selectedDate);
      setState(() {
        _headerDateFormat = '${shamsiDate.formatter.wN}، ${shamsiDate.formatter.d} ${shamsiDate.formatter.mN} ${shamsiDate.formatter.yyyy}';
      });
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          final keyboardOffset = MediaQuery.of(context).viewInsets.bottom;
          return StatefulBuilder(
            builder: (context, setState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (keyboardOffset > 0) {
                  setState(() {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                }
              });
              return SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  bottom: keyboardOffset + MediaQuery.of(context).padding.bottom,
                ),
                child: SizedBox(
                  height: widget.calendarUsecase == 2 ? MediaQuery.of(context).size.height * 0.7 : MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    children: [
                      Container(
                        height: 50, // adjust as needed
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'مشاهده رویداد',
                          style: TextStyle(color: widget.calendarUsecase == 2 ? Colors.orange[600] : Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: CalendarModal()),
                      Visibility(visible: widget.calendarUsecase == 2, child: const SizedBox(height: 15)),
                      Visibility(
                        visible: widget.calendarUsecase == 2,
                        child: SizedBox(
                          height: 55,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red[400]!)),
                                    child: const Text('برگشت'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange[400]!)),
                                    onPressed: () {},
                                    child: const Text('لیست حضور غیاب'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
