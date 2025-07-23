import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: bottomnavigationrobbery2(),
    );
  }
}

class bottomnavigationrobbery2 extends StatefulWidget {
  @override
  _bottomnavigationrobbery2 createState() => _bottomnavigationrobbery2();
}

class _bottomnavigationrobbery2 extends State<bottomnavigationrobbery2> {
  int _selectedIndex = 0;

  // List of pages for each tab in BottomNavigationBar
  final List<Widget> _pages = [
    PostingPage(),
    RobberyPage(),

  ];

  // Function to handle BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin Dashboard')),
        backgroundColor: Colors.blueAccent,
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Posting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.get_app),
            label: 'Fetch',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Placeholder pages for each BottomNavigationBar item
class PostingPage extends StatefulWidget {
  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {


  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref("Robber");

  // Controllers for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _engineController = TextEditingController();
  final TextEditingController _incidentDateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _robberDetailsController = TextEditingController();
  final TextEditingController _witnessContactController = TextEditingController();

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
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _registrationController.dispose();
    _engineController.dispose();
    _incidentDateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _robberDetailsController.dispose();
    _witnessContactController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      final User? user = _auth.currentUser;
      if (user != null) {
        // Retrieve engine number
        final String engineNumber = _engineController.text;

        // Prepare data
        Map<String, String> reportData = {
          "victim_name": _nameController.text,
          "contact_info": _contactController.text,
          "address": _addressController.text,
          "bike_make": _makeController.text,
          "bike_model": _modelController.text,
          "bike_color": _colorController.text,
          "registration_number": _registrationController.text,
          "engine_chassis_number": engineNumber,
          "incident_date": _incidentDateController.text,
          "incident_location": _locationController.text,
          "incident_description": _descriptionController.text,
          "robber_details": _robberDetailsController.text,
          "witness_contact": _witnessContactController.text,
          "reported_by": user.email ?? '',
        };

        // Save data under "Robberies/$engineNumber"
        await _database.child("Robberies").child(engineNumber).set(reportData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report submitted successfully')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please log in first')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                          )
                      ),


                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      )
                  ),

                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(11),  // Limit input to 11 digits
                ],
                controller: _contactController,
                decoration: InputDecoration(
                    labelText: 'Contact Information',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

                validator: (value) => value!.isEmpty ? 'Please enter contact information' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                    labelText: 'Address',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _makeController,
                decoration: InputDecoration(
                    labelText: 'Bike Make',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                    labelText: 'Bike Model',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _colorController,
                decoration: InputDecoration(
                    labelText: 'Bike Color',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _registrationController,
                decoration: InputDecoration(
                    labelText: 'Registration Number',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _engineController,
                decoration: InputDecoration(
                    labelText: 'Engine or Chassis Number',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

                validator: (value) => value!.isEmpty ? 'Please enter engine number' : null,
              ),
              SizedBox(height: 15),

              TextFormField(
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



              SizedBox(height: 15),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                    labelText: 'Location of Incident',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: 'Incident Description',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _robberDetailsController,
                decoration: InputDecoration(
                    labelText: 'Robber Details (Appearance, Clothing)',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _witnessContactController,
                decoration: InputDecoration(
                    labelText: 'Witness Contact Information',

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),


                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                ),

              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
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
                  onPressed: _submitReport,
                  child: Text('Submit Report',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RobberyPage extends StatefulWidget {
  @override
  State<RobberyPage> createState() => _RobberyPageState();
}

class _RobberyPageState extends State<RobberyPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref("Robber");
  final TextEditingController _engineController = TextEditingController();
  String? _engineNumber;

  @override
  void dispose() {
    _engineController.dispose();
    super.dispose();
  }

  void _deleteRecord() {
    if (_engineNumber != null) {
      _database.child("Robberies").child(_engineNumber!).remove().then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record deleted successfully.')),
        );
        setState(() {
          _engineNumber = null;
          _engineController.clear();
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete record: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 330,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50], // Light blue background color
                borderRadius: BorderRadius.circular(8), // Rounded corners for better appearance
              ),
              padding: EdgeInsets.symmetric(horizontal: 8), // Inner padding
              child: SizedBox(
                width: 340,
                child: TextField(
                  controller: _engineController,
                  decoration: InputDecoration(
                    labelText: 'Enter Engine Number',
                    border: OutlineInputBorder(),
                    filled: false, // Prevents the default fill color from clashing
                  ),
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
                      return Column(
                        children: [
                          Expanded(child: _buildReportDetails(report)),
                          ElevatedButton(
                            onPressed: _deleteRecord,
                            child: Text('Delete Record', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
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
}





























