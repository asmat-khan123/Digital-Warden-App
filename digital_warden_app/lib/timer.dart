import 'package:flutter/material.dart';

class Timers extends StatefulWidget{
  @override
  State<Timers> createState() => _TimersState();
}

class _TimersState extends State<Timers> {
  final TextEditingController _incidentDateController = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    // Date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Time picker
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _incidentDateController.text =
        "${pickedDateTime.year}-${pickedDateTime.month.toString().padLeft(2, '0')}-${pickedDateTime.day.toString().padLeft(2, '0')} "
            "${pickedTime.format(context)}";
      }
    }
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _incidentDateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Incident Date and Time',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onTap: () => _selectDateTime(context),
      ),
    ),
  );
  }
}