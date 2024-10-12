import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks; // Start with two weeks view
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return  TableCalendar(
        firstDay: DateTime(2000),
        lastDay: DateTime(DateTime.now().year, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        calendarStyle: CalendarStyle(
          defaultTextStyle: const TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: "Podkova"),
          weekendTextStyle: const TextStyle(
              color: Colors.red, fontSize: 16, fontFamily: "Podkova"),
          selectedTextStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: "Podkova"),
          todayTextStyle: const TextStyle(
              color: Colors.blue, fontSize: 16, fontFamily: "Podkova"),
          outsideTextStyle: const TextStyle(
              color: Colors.grey, fontSize: 16, fontFamily: "Podkova"),
          disabledTextStyle: TextStyle(
              color: Colors.grey.withOpacity(0.4), fontFamily: "Podkova"),
        ),
        headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Podkova"),
          formatButtonTextStyle:
          TextStyle(color: Colors.black, fontFamily: "Podkova"),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

    );
  }
}
