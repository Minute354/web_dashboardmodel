import 'package:flutter/material.dart';
import 'package:school_web_app/models/timetable_model.dart';

class TimetableForm extends StatefulWidget {
  final String className;
  final String division;
  final String day;
  final String timeSlot;
  final TimetableEntry? initialEntry;
  final Function(TimetableEntry) onSubmit;

  TimetableForm({
    required this.className,
    required this.division,
    required this.day,
    required this.timeSlot,
    this.initialEntry,
    required this.onSubmit,
  });

  @override
  _TimetableFormState createState() => _TimetableFormState();
}

class _TimetableFormState extends State<TimetableForm> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController teacherController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialEntry != null) {
      subjectController.text = widget.initialEntry!.subject;
      teacherController.text = widget.initialEntry!.teacher;
      roomNumberController.text = widget.initialEntry!.roomNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: subjectController,
          decoration: InputDecoration(labelText: 'Subject'),
        ),
        TextField(
          controller: teacherController,
          decoration: InputDecoration(labelText: 'Teacher'),
        ),
        TextField(
          controller: roomNumberController,
          decoration: InputDecoration(labelText: 'Room Number'),
        ),
        ElevatedButton(
          onPressed: () {
            final newEntry = TimetableEntry(
              className: widget.className,
              division: widget.division,
              day: widget.day,
              timeSlot: widget.timeSlot,
              subject: subjectController.text,
              teacher: teacherController.text,
              roomNumber: roomNumberController.text,
            );
            widget.onSubmit(newEntry);
          },
          child: Text(widget.initialEntry == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
