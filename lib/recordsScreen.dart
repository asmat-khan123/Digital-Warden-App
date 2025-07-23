import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class SubmitDataPage extends StatefulWidget {
  @override
  _SubmitDataPageState createState() => _SubmitDataPageState();
}

class _SubmitDataPageState extends State<SubmitDataPage> {
  // TextEditingControllers for form fields
  var name = TextEditingController();
  var home = TextEditingController();
  var phone = TextEditingController();
  var vehiclenumber = TextEditingController();
  var vihivlemake = TextEditingController();
  var place = TextEditingController();
  var documentnumber = TextEditingController();
  var remarks = TextEditingController();
  var amount;
  String? dropdownvalue;
  String? selectedValue;

  String radioo = "male";
  String radiooo = "Driver";
  int baseNumber = 40980000000020;

  final DatabaseReference database = FirebaseDatabase.instance.ref();

  // Incident date controller
  final TextEditingController _incidentDateController = TextEditingController();

  // Function to format and store date
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  // Submit data to Firebase
  void submitData() async {
    // Get the formatted date and time from the controller
    String formattedDateTime = _incidentDateController.text;

    if (formattedDateTime.isEmpty) {
      // If no date was selected, format current date and time
      formattedDateTime = _formatDateTime(DateTime.now());
    }

    // Organize form data
    Map<String, dynamic> formData = {
      'name': name.text,
      'home': home.text,
      'phone': phone.text,
      'vehiclenumber': vehiclenumber.text,
      'vihivlemake': vihivlemake.text,
      'place': place.text,
      'documentnumber': documentnumber.text,
      'remarks': remarks.text,
      'valuation': dropdownvalue,
      'document_in_custody': selectedValue,
      'amount': amount.toString(),
      'gender': radioo,
      'role': radiooo,
      'dateandtime': formattedDateTime,
    };

    // Store data using `baseNumber` as unique identifier
    try {
      await database.child('Records/$baseNumber').set(formData);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data submitted successfully!'))
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting data: $error'))
      );
    }
  }

  // Function to open date and time picker
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
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
        _incidentDateController.text = _formatDateTime(pickedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submit Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: home,
              decoration: InputDecoration(labelText: 'Home'),
            ),
            TextField(
              controller: phone,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            // Add other fields here...

            // Date and Time Picker
            TextField(
              controller: _incidentDateController,
              decoration: InputDecoration(
                labelText: 'Incident Date and Time',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDateTime(context),
                ),
              ),
              readOnly: true, // Disable manual editing
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
