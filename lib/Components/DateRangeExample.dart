import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../forms/theme.dart';

class DateRangeExample extends StatefulWidget {
  @override
  _DateRangeExampleState createState() => _DateRangeExampleState();

  final TextEditingController? controller;
  final RxString? selectedDate;
  final RxString? dateformat;
  final bool? isCurrentData;

  const DateRangeExample({
    @required this.controller,
    @required this.selectedDate,
    @required this.dateformat,
    this.isCurrentData = false,
  });
}

class _DateRangeExampleState extends State<DateRangeExample> {
  DateTimeRange? _selectedDateRange;
  bool thismonth = false;
  bool lastmonth = false;
  bool lastyear = false;

  DateTime selectedDay = DateTime.now();
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  bool _isDateEnabled(DateTime day) {
    // Enable only future dates or the current date
    return day.isAfter(_currentDate) || _isSameDay(day, _currentDate);
  }

  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 115),
                  child: Text("Select Dates",
                      style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear))
              ],
            ),
          ),
          SizedBox(height: 10),
          TableCalendar(
              firstDay: DateTime.utc(_currentDate.year - 1),
              lastDay: widget.isCurrentData!
                  ? DateTime.now()
                  : DateTime.utc(_currentDate.year + 2),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.black),
                selectedDecoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  shape: BoxShape.rectangle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              rangeStartDay: DateTime.now(),
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              availableGestures: AvailableGestures.none,
              // Disable selecting previous dates
              onDaySelected: (DateTime selectedDate, DateTime focusedDate) {
                setState(() {
                  selectedDay = selectedDate;
                  widget.selectedDate?.value =
                      formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);

                  widget.dateformat?.value =
                      formatDate(selectedDate, [dd, '.', M, '.', yyyy]);
                });
              },
              // locale: "en_US",
              rowHeight: 35,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.black),
              ),
              focusedDay: selectedDay,
              daysOfWeekVisible: true,
              calendarBuilders:
                  CalendarBuilders(selectedBuilder: (context, date, _) {
                return Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5)),
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
