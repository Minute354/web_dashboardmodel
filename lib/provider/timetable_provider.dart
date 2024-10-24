import 'package:flutter/foundation.dart';
import 'package:school_web_app/models/timetable_model.dart';

class TimetableController with ChangeNotifier {
  List<TimetableEntry> _entries = [];

  List<TimetableEntry> get entries => _entries;

  void addEntry(TimetableEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void editEntry(int index, TimetableEntry updatedEntry) {
    _entries[index] = updatedEntry;
    notifyListeners();
  }

  TimetableEntry? findEntry(String className, String division, String day, String timeSlot) {
    return _entries.firstWhere(
      (entry) =>
        entry.className == className &&
        entry.division == division &&
        entry.day == day &&
        entry.timeSlot == timeSlot,
    );
  }
}
