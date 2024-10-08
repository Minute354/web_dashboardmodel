import 'package:flutter/material.dart';
import 'package:school_web_app/models/calendar_holiday_model.dart';


class HolidayController with ChangeNotifier {
  List<Holiday> _holidays = [];

  // Get list of holidays
  List<Holiday> get holidays => _holidays;

  // Method to add a holiday (dynamic)
  void addHoliday(Holiday holiday) {
    _holidays.add(holiday);
    notifyListeners();
  }

  // Fetch holidays dynamically (replace with API integration if needed)
  void fetchHolidays() {
    _holidays = [
      Holiday(
        title: 'New Year\'s Day',
        description: 'First day of the year, celebrated worldwide.',
        date: DateTime(2024, 1, 1),
      ),
      Holiday(
        title: 'Independence Day',
        description: 'Celebration of national independence.',
        date: DateTime(2024, 7, 4),
      ),
      Holiday(
        title: 'Christmas Day',
        description: 'Celebration of Christmas.',
        date: DateTime(2024, 12, 25),
      ),
    ];
    notifyListeners();
  }

  // Method to retrieve holiday details based on the selected date
 Holiday? getHolidayByDate(DateTime date) {
  try {
    return _holidays.firstWhere(
      (holiday) =>
          holiday.date.year == date.year &&
          holiday.date.month == date.month &&
          holiday.date.day == date.day,
    );
  } catch (e) {
    return null; // Explicitly return null if no holiday is found
  }
}

}




