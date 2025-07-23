import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Mazda extends StatefulWidget {
  @override
  State<Mazda> createState() => _MazdaState();
}

class _MazdaState extends State<Mazda> {
  @override
  final _formKey = GlobalKey<FormState>();
  var name=TextEditingController();
  var home=TextEditingController();
  var phone=TextEditingController();
  var vehiclenumber=TextEditingController();
  var vihivlemake=TextEditingController();
  var place=TextEditingController();
  var documentnumber=TextEditingController();
  var remarks=TextEditingController();
  var amount;

  int baseNumber = 40980000000000;
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  Future<void> fetchLastBaseNumber() async {
    DataSnapshot snapshot = await database.child('Records').get();

    if (snapshot.exists) {
      int highestNumber = baseNumber; // Default if no records found
      snapshot.children.forEach((child) {
        int currentNumber = int.tryParse(child.key ?? '') ?? 0;
        if (currentNumber > highestNumber) {
          highestNumber = currentNumber;
        }
      });

      setState(() {
        baseNumber = highestNumber + 1; // Set baseNumber to next unique ID
      });
    } else {
      setState(() {
        baseNumber = baseNumber + 1; // Start with initial value if no data
      });
    }
  }



  void initState() {
    super.initState();
    fetchLastBaseNumber();
    amount = null;

  }
  bool isLoading = false;

  void submitData() {
    setState(() {
      isLoading = true; // Start loading
    });

    // Organize data into a map
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
      'dateandtime': _incidentDateController.text,
    };

    // Store data using `baseNumber` as the unique identifier
    database.child('Records/$baseNumber').set(formData).then((_) {
      setState(() {
        isLoading = false; // Stop loading once data is successfully submitted
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data submitted successfully!')),
      );

      // Clear all fields after successful submission
      name.clear();
      home.clear();
      phone.clear();
      vehiclenumber.clear();
      vihivlemake.clear();
      place.clear();
      documentnumber.clear();
      remarks.clear();
      amount.clear();
      _incidentDateController.clear();
    }).catchError((error) {
      setState(() {
        isLoading = false; // Stop loading if there's an error
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting data: $error')),
      );
    });
  }































  @override
  String? dropdownvalue;
  var items = [

    'Over speeding',
    'Overloading of passengers',
    'Signal violation',
    'Overloading of goods',
    'Driving without proper lights',
    'One way violation',
    'Use of tinted glasses',
    'Line and lane violation',
    'Driving in prohibited area',
    'Traffic obstruction',
    'Rash & negligent driving',
    'Driving without license',
    'Use of pressure/musical harm',
    'Emitting excessive smoke',
    'Vehicle without registration',
    'Juvenile driving',
    'Use of mobile phones while driving',
    'Seat belt violation',
    'Wrong parking',
    'Others',
    'Lifter Challan',
  ];
  var khan={
    'Over speeding':300,
    'Overloading of passengers':1000,
    'Signal violation':600,
    'Overloading of goods':1500,
    'Driving without proper lights':200,
    'One way violation':700,
    'Use of tinted glasses':400,
    'Line and lane violation':3000,
    'Driving in prohibited area':1000,
    'Traffic obstruction':500,
    'Rash & negligent driving':700,
    'Driving without license':2000,
    'Use of pressure/musical harm':500,
    'Emitting excessive smoke':500,
    'Vehicle without registration':2000,
    'Juvenile driving':1000,
    'Use of mobile phones while driving':1000,
    'Seat belt violation':500,
    'Wrong parking':300,
    'Others':1000,
    'Lifter Challan':500,

  };
  String? selectedValue;
  final List<String> itemss = [  'CNIC',
    'License',
    'Route Permit',
    'Vehicle Registration Book',
    'Vehicle Impounded'];
  String radioo="male";
  String radiooo="Driver";
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Center(child: Padding(

          padding: const EdgeInsets.only(right: 80),
          child: Text("Mazda",style: TextStyle(fontWeight: FontWeight.bold,),),
        )),
      ),
      body:Center(

        child: Container(
          width: 325,
          color: Colors.white,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(

                    labelText: "Name of Violator",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),

                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child:TextField(
                  controller: home,
                  decoration: InputDecoration(

                    labelText: "Home Address",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),
                ),
              ),


              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    LengthLimitingTextInputFormatter(11),  // Limit input to 11 digits
                  ],
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 0,right: 120,bottom: 10),
                    child: Text("Who is driving the vehicle?" ,style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Driver", groupValue:  radiooo, onChanged: (value) {
                              setState(() {
                                radiooo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Driver",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Owner", groupValue: radiooo, onChanged: (value) {
                              setState(() {
                                radiooo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Owner",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Other", groupValue: radiooo, onChanged: (value) {
                              setState(() {
                                radiooo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Other",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 0,right: 120,bottom: 10),
                    child: Text("Select gender of the driver?" ,style: TextStyle(
                        fontSize: 15,

                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Male", groupValue: radioo, onChanged: (value) {
                              setState(() {
                                radioo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Male",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Female", groupValue: radioo, onChanged: (value) {
                              setState(() {
                                radioo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Female",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Radio(value: "Other", groupValue: radioo, onChanged: (value) {
                              setState(() {
                                radioo=value!;
                              });
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Other",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  margin: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller:vehiclenumber ,
                    decoration: InputDecoration(
                        labelText: 'Enter Vehicle number',

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

                    validator: (value) => value!.isEmpty ? 'Please enter Vehicle number' : null,
                  ),
                ),
                // labelText: "Vehicle Number",
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  controller: vihivlemake,
                  decoration: InputDecoration(

                    labelText: "Vehicle Make",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 1,color: Colors.black45)
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: DropdownButton(
                      hint: Text( 'Choose Violations'),
                      // Initial Value
                      value: dropdownvalue,
                      isExpanded: true,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: SizedBox.shrink(),
                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          amount = khan[dropdownvalue] ?? 'Null';

                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 1,color: Colors.black45)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: DropdownButton<String>(
                    hint: Text( 'Select Documment Confiscated'),
                    underline: SizedBox.shrink(),
                    isExpanded: true,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: itemss.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 270,top: 15),
                    child: Text("Amount",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                  ),
                  Container(

                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10),

                      child: Text("$amount",style: TextStyle(

                          fontSize: 20,
                          color: Colors.black87
                      ),),
                    ),
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black45),
                        borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  controller: place,
                  decoration: InputDecoration(

                    labelText: "Place Of Challan",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  controller: documentnumber,
                  decoration: InputDecoration(

                    labelText: "Document Number",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  controller: remarks,
                  decoration: InputDecoration(

                    labelText: "Remarks",

                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(
                          color: Colors.black45,
                          width: 1
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
                        )
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
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
                )
                ,
              ),




              InkWell(
                onTap:() {
                  if (_formKey.currentState!.validate()) {
                    showAlertDialog(context);

                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Validation failed! Please enter a Vehicle Number.')),
                    );
                  }




                } ,
                child: Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.only(top: 15,bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      border:Border.all(
                          color: Colors.black45,
                          width: 1
                      )
                  ),

                  child: Center(child:isLoading
                      ? CircularProgressIndicator(color: Colors.white) // Show loading indicator while loading
                      : Text('GENERATE CHALLAN'),



                  ),
                ),
              )



            ],
          ),
        ),
      ),

    );
  }
  Future<void> incrementNumber() async => setState(() {
    baseNumber += 1;
    baseNumber.toString().padLeft(14, '0');
  });

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Note"),
          content: Text("Do you want to Generate Challan?"),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            // OK Button
            TextButton(
              onPressed: () {
                incrementNumber(); // Call incrementNumber function
                submitData();      // Call submitData function
                Navigator.of(context).pop(); // Close the dialog after action
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

}