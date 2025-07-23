import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RobberyReportPage extends StatefulWidget {
  @override
  _RobberyReportPageState createState() => _RobberyReportPageState();
}

class _RobberyReportPageState extends State<RobberyReportPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref("Robber");
  final TextEditingController _engineController = TextEditingController();
  String? _engineNumber;

  @override
  void dispose() {
    _engineController.dispose();
    super.dispose();
  }

  Widget _buildReportDetails(Map<String, dynamic> report) {
    return ListView(
      children: [
        SizedBox(height: 20),
        _buildSection("Victim Information", [
          _buildDetailRow("Name", report['victim_name']),
          _buildDetailRow("Contact", report['contact_info']),
          _buildDetailRow("Address", report['address']),
        ]),
        _buildSection("Bike Details", [
          _buildDetailRow("Make", report['bike_make']),
          _buildDetailRow("Model", report['bike_model']),
          _buildDetailRow("Color", report['bike_color']),
          _buildDetailRow("Registration", report['registration_number']),
          _buildDetailRow("Engine/Chassis No.", report['engine_chassis_number']),
        ]),
        _buildSection("Incident Details", [
          _buildDetailRow("Date and Time", report['incident_date']),
          _buildDetailRow("Location", report['incident_location']),
          _buildDetailRow("Description", report['incident_description']),
        ]),
        _buildSection("Robber and Witness Details", [
          _buildDetailRow("Robber Details", report['robber_details']),
          _buildDetailRow("Witness Contact", report['witness_contact']),
        ]),
        _buildSection("Report Information", [
          _buildDetailRow("Reported By", report['reported_by']),
        ]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...details,
        Divider(),
      ],
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robbery Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 330,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50], // Light blue background color
                borderRadius: BorderRadius.circular(8), // Rounded corners for better appearance
              ),
              child: TextField(
                controller: _engineController,
                decoration: InputDecoration(
                  labelText: 'Enter Engine Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue, // Text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _engineNumber = _engineController.text.trim();
                  });
                },
                child: Text('Fetch Report', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            if (_engineNumber != null)
              Expanded(
                child: StreamBuilder(
                  stream: _database.child("Robberies").child(_engineNumber!).onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || (snapshot.data! as DatabaseEvent).snapshot.value == null) {
                      return Center(child: Text('No report found for this engine number.'));
                    } else {
                      final report = Map<String, dynamic>.from((snapshot.data! as DatabaseEvent).snapshot.value as Map);
                      return _buildReportDetails(report);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
