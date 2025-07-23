import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FeetchDataPage extends StatefulWidget {
  @override
  _FeetchDataPageState createState() => _FeetchDataPageState();
}

class _FeetchDataPageState extends State<FeetchDataPage> {
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
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("PSID: ${record['baseNumber']}"),
            pw.Text("Violator Name: ${record['name'] ?? 'No Name'}"),
            pw.Text("Phone: ${record['phone'] ?? 'No Phone'}"),
            pw.Text("Vehicle Number: ${record['vehiclenumber'] ?? 'No Vehicle Number'}"),
            pw.Text("Date and Time: ${record['dateandtime'] ?? 'No Date'}"),
            pw.Text("Vehicle Type: ${record['vihivlemake'] ?? 'No Vehicle Make'}"),
            pw.Text("Fine: ${record['amount'] ?? 'No Amount'}"),
            pw.Text("Document Confiscated: ${record['document_in_custody'] ?? 'No Document'}"),
            pw.Text("Type of Violation: ${record['valuation'] ?? 'No Valuation'}"),
            pw.Text("Place of Challan: ${record['place'] ?? 'No Place'}"),
            pw.Text("Document Status: ${record['documentnumber'] ?? 'No Document Number'}"),
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
      appBar: AppBar(title: Text('Fetch and Sort Data')),
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

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available.'));
                  }

                  Map<dynamic, dynamic> recordsMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  List<Map<dynamic, dynamic>> recordsList = [];
                  recordsMap.forEach((key, value) {
                    String dateString = value['dateandtime'] ?? '';
                    DateTime recordDate = _parseDate(dateString);
                    if (_isDateInRange(recordDate)) {
                      Map<dynamic, dynamic> record = Map<dynamic, dynamic>.from(value);
                      record['baseNumber'] = key;
                      recordsList.add(record);
                    }
                  });

                  recordsList.sort((a, b) {
                    DateTime dateA = _parseDate(a['dateandtime'] ?? '');
                    DateTime dateB = _parseDate(b['dateandtime'] ?? '');
                    return dateA.compareTo(dateB);
                  });

                  return ListView.builder(
                    itemCount: recordsList.length,
                    itemBuilder: (context, index) {
                      var record = recordsList[index];
                      String baseNumber = record['baseNumber'] ?? 'No Base Number';

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ExpansionTile(
                          title: Text("PSID: $baseNumber"),
                          subtitle: Text('Violator Name: ${record['name'] ?? 'No Name'}'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date and Time: ${record['dateandtime'] ?? 'No Date'}"),
                                  Text("Vehicle Number: ${record['vehiclenumber'] ?? 'No Vehicle Number'}"),
                                  Text("Vehicle Type: ${record['vihivlemake'] ?? 'No Vehicle Make'}"),
                                  Text("Document Confiscated: ${record['document_in_custody'] ?? 'No Document'}"),
                                  Text("Fine: ${record['amount'] ?? 'No Amount'}"),
                                  Text("Type of Violation: ${record['valuation'] ?? 'No Valuation'}"),
                                  Text("Place of Challan: ${record['place'] ?? 'No Place'}"),
                                  Text("Document Status: ${record['documentnumber'] ?? 'No Document Number'}"),
                                  SizedBox(height: 10),
                                  Center(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _printRecord(record),
                                      icon: Icon(Icons.print),
                                      label: Text("Print Record"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
