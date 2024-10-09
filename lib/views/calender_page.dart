import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/calendar_holiday_controller.dart';
import 'package:school_web_app/models/calendar_holiday_model.dart';
import 'package:school_web_app/views/calender_add_holidaypage.dart';
import 'package:school_web_app/views/sidebars.dart';

import 'package:table_calendar/table_calendar.dart';

class HolidayCalendarPage extends StatefulWidget {
  @override
  _HolidayCalendarPageState createState() => _HolidayCalendarPageState();
}

class _HolidayCalendarPageState extends State<HolidayCalendarPage> {
  DateTime _selectedDay = DateTime.now();
  Holiday? _selectedHoliday;

  @override
  void initState() {
    super.initState();
    // Fetch the holidays on page load
    Provider.of<HolidayController>(context, listen: false).fetchHolidays();
  }

  @override
  Widget build(BuildContext context) {
    final holidayController = Provider.of<HolidayController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Holiday Calendar'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 200, top: 50),
                    child: Card(
                      color: Colors.grey,
                      elevation: 10,
                      child: Container(
                        height: 350,
                        margin: EdgeInsets.all(100),
                        child: TableCalendar(
                          focusedDay: _selectedDay,
                          firstDay: DateTime(2020),
                          lastDay: DateTime(2030),
                          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _selectedHoliday = holidayController.getHolidayByDate(selectedDay);
                            });
                          },
                          holidayPredicate: (day) {
                            return holidayController.getHolidayByDate(day) != null;
                          },
                          calendarStyle: CalendarStyle(
                            holidayTextStyle: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            holidayDecoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.blueGrey.shade900,
                              shape: BoxShape.circle,
                            ),
                            todayDecoration: BoxDecoration(
                              color: Colors.blueGrey.shade500,
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                              color: Colors.blueGrey.shade900,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_selectedHoliday != null)
                    HolidayDetailsWidget(holiday: _selectedHoliday!)
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Select a date to view holiday details.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(flex: 2,child: Padding(
            padding: const EdgeInsets.only(right: 250,top: 100),
            child: AddHolidayPage(),
          ))
        ],
      ),
    );
  }
}

class HolidayDetailsWidget extends StatelessWidget {
  final Holiday holiday;

  const HolidayDetailsWidget({required this.holiday});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              holiday.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              holiday.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${holiday.date.day}-${holiday.date.month}-${holiday.date.year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
