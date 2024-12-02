import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/calendar_holiday_controller.dart';
import '../models/calendar_holiday_model.dart';
import 'package:intl/intl.dart'; // For date formatting

class AddHolidayPage extends StatefulWidget {
  @override
  _AddHolidayPageState createState() => _AddHolidayPageState();
}

class _AddHolidayPageState extends State<AddHolidayPage> {
  final _formKey = GlobalKey<FormState>();
  final _holidayTitleController = TextEditingController();
  final _holidayTypeController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Holiday name text field
            TextFormField(
              controller: _holidayTitleController,
              decoration: InputDecoration(labelText: 'Holiday Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a holiday name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Holiday type text field
            TextFormField(
              controller: _holidayTypeController,
              decoration: InputDecoration(labelText: 'Holiday Type'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the holiday type';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // Date picker for selecting holiday date
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: _selectedDate == null
                        ? 'Select Holiday Date'
                        : 'Holiday Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select a holiday date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),

            // Add holiday button
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white38)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addHoliday(context);
                }
              },
              child: Text(
                'Add Holiday',
                style: GoogleFonts.poppins(color: Colors.blueGrey.shade900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to pick a date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to add the holiday using the controller
  void _addHoliday(BuildContext context) {
    final holidayController =
        Provider.of<HolidayController>(context, listen: false);

    holidayController.addHoliday(
      Holiday(
        title: _holidayTitleController.text,
        description: 'Holiday Description', // This can be modified as needed
        date: _selectedDate!,
        type: _holidayTypeController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Holiday Added Successfully')),
    );

    // Clear the form after submission
    _holidayTitleController.clear();
    _holidayTypeController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  @override
  void dispose() {
    _holidayTitleController.dispose();
    _holidayTypeController.dispose();
    super.dispose();
  }
}
