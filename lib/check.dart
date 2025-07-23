import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FeetchDataPageaa extends StatefulWidget {
  @override
  _FeetchDataPageaaState createState() => _FeetchDataPageaaState();
}

class _FeetchDataPageaaState extends State<FeetchDataPageaa> {
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  bool _isDateInRange(DateTime recordDate) {
    if (startDate != null && endDate != null) {
      return recordDate.isAfter(startDate!.subtract(Duration(days: 1))) &&
          recordDate.isBefore(endDate!.add(Duration(days: 1)));
    }
    return true;
  }

  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm').parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  Future<void> _pickDate(BuildContext context, TextEditingController controller, bool isStartDate) async {
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
        controller.text = _formatDateTime(pickedDateTime);
        setState(() {
          if (isStartDate) {
            startDate = pickedDateTime;
          } else {
            endDate = pickedDateTime;
          }
        });
      }
    }
  }

  Future<void> _printRecord(Map<dynamic, dynamic> record) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Punjab Police - Challan Details",
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
            pw.SizedBox(height: 10),
            pw.Text("PSID: ${record['baseNumber']}", style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 8),
            pw.Text("Vehicle Number: ${record['vehiclenumber'] ?? 'No Vehicle Number'}", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 8),

            pw.Text("Fine: ${record['amount'] ?? 'No Amount'}", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text("Date and Time: ${record['dateandtime'] ?? 'No Date'}", style: pw.TextStyle(fontSize: 16)),

            pw.SizedBox(height: 8),
            pw.Text("Notes:",style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text("If the challan is not paid within the due",style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 4),
            pw.Text("date. additional penalties may be imposed.",style: pw.TextStyle(fontSize: 16)),




          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Fetch and Sort Data', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context, startDateController, true),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          labelText: "Start Date",
                          border: OutlineInputBorder(),
                          fillColor: Colors.blue.shade50,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context, endDateController, false),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          labelText: "End Date",
                          border: OutlineInputBorder(),
                          fillColor: Colors.blue.shade50,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: database.child('Records').onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                    return Center(child: Text('No data available.'));
                  }

                  Map<dynamic, dynamic> recordsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  if (recordsMap.isEmpty) {
                    return Center(child: Text('No records found.'));
                  }

                  List<Map<dynamic, dynamic>> recordsList = [];
                  recordsMap.forEach((key, value) {
                    if (value != null) {
                      String dateString = value['dateandtime'] ?? '';
                      DateTime recordDate = _parseDate(dateString);
                      if (_isDateInRange(recordDate)) {
                        Map<dynamic, dynamic> record = Map<dynamic, dynamic>.from(value);
                        record['baseNumber'] = key;
                        recordsList.add(record);
                      }
                    }
                  });

                  recordsList.sort((a, b) => b['baseNumber'].compareTo(a['baseNumber']));

                  return ListView.builder(
                    itemCount: recordsList.length,
                    itemBuilder: (context, index) {
                      final record = recordsList[index];
                      return Card(
                        color: Colors.blue.shade50,
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text('PSID: ${record['baseNumber']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text('Name: ${record['name'] ?? 'No Name'}', style: TextStyle(fontSize: 14)),
                          trailing: IconButton(
                            icon: Icon(Icons.print, color: Colors.blue),
                            onPressed: () => _printRecord(record),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
