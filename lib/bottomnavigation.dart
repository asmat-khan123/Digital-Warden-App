import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminDashboardd(),
    );
  }
}

class AdminDashboardd extends StatefulWidget {
  @override
  _AdminDashboarddState createState() => _AdminDashboarddState();
}

class _AdminDashboarddState extends State<AdminDashboardd> {
  int _selectedIndex = 0;

  // List of pages for each tab in BottomNavigationBar
  final List<Widget> _pages = [
    PostingPage(),
    CriminalPage(),
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
            icon: Icon(Icons.update),
            label: 'Update',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
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

  var gmail=TextEditingController();
  var passwords=TextEditingController();
  var namee=TextEditingController();
  var fnamee=TextEditingController();
  var phonee=TextEditingController();
  var cnicc=TextEditingController();
  var post=TextEditingController();
  var district=TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref('post');
  Future<void> registerUser(String email, String password, String name, String phone, String fname, String cnic, String post,String district) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        Fluttertoast.showToast(
          msg: "Successfull Submit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // You can change to TOP or CENTER
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }




      // Get user ID
      String uid = userCredential.user!.uid;

      // Store user data in Realtime Database
      DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$uid');
      await userRef.set({
        'email': email,
        'name': name,
        'phone': phone,
        'fname': fname,
        'cnic': cnic,
        'district' : district,
        'post': post
      });

      print("User registered successfully");
    } catch (e) {

      Fluttertoast.showToast(
        msg: "Not Submit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // You can change to TOP or CENTER
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error registering user: $e");
    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Container(

        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 10),
                child: CircleAvatar(

                  backgroundImage: AssetImage('assets/images/police3.jpg'),


                ),
              ),
              Container(height: 15,),

              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(

                        child: Text("Name",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        controller: namee,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Colors.blue,),

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
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("Father Name",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(

                        controller: fnamee,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Colors.blue,),

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
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("Phone Number",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                          LengthLimitingTextInputFormatter(11),  // Limit input to 11 digits
                        ],
                        controller: phonee,

                        decoration: InputDecoration(
hintText: "03............",
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
                            prefixIcon: Icon(Icons.phone_android,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("CNIC",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        controller: cnicc,

                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                          LengthLimitingTextInputFormatter(13),  // Limit input to 11 digits
                        ],
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.credit_card_outlined,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("District: ",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        controller: district,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.location_on_outlined,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("Post: ",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        controller: post,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.post_add,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("Gmail",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:60,
                      child: TextField(

                        controller: gmail,
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.email,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        child: Text("Password",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 5),
                    child: Container(
                      width: 300,
                      height:50,
                      child: TextField(
                        controller: passwords,

                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.lock_open_outlined,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 7,),
              Padding(

                padding: const EdgeInsets.only(left: 40,bottom: 30,top: 15),
                child: Row(
                  children: [



                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Container(
                        width: 200,
                        height: 50,

                        child: ElevatedButton(
                          onPressed: () async {
                            String email = gmail.text.toString();
                            String password = passwords.text.toString();
                            String name = namee.text.toString();
                            String phone = phonee.text.toString();
                            String fname = fnamee.text.toString();
                            String cnic = cnicc.text.toString();
                            String posts = post.text.toString();
                            String districts = district.text.toString();
                            // Register user
                            await registerUser(email, password, name, phone, fname, cnic, posts, districts);
                          },
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
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white, // Text color (redundant here as it's set in `onPrimary`)
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ),
                    )

                  ],




                ),
              ),


            ],




          ),
        ),
      ),
    );
  }
}



class CriminalPage extends StatefulWidget {
  @override
  State<CriminalPage> createState() => _CriminalPageState();
}

class _CriminalPageState extends State<CriminalPage> {

  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  // Fetch user data based on Gmail
  Future<void> _fetchUserData() async {
    String email = _gmailController.text.trim();

    // Reference to the users in the database
    DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
    DatabaseEvent event = await usersRef.once();  // Get all users at once

    if (event.snapshot.exists) {
      // Safely convert snapshot value to a map
      Map<dynamic, dynamic> usersMap = event.snapshot.value as Map<dynamic, dynamic>;
      String? uid;

      // Find UID based on email
      for (var entry in usersMap.entries) {
        if (entry.value['email'] == email) {
          uid = entry.key; // Get the UID
          break;
        }
      }

      if (uid != null) {
        // Fetch user data using UID
        DatabaseReference userRef = usersRef.child(uid);
        DatabaseEvent userEvent = await userRef.once();

        if (userEvent.snapshot.exists) {
          // Safely convert user snapshot value to a map
          Map<dynamic, dynamic> userDataMap = userEvent.snapshot.value as Map<dynamic, dynamic>;
          setState(() {
            _phoneController.text = userDataMap['phone'] ?? '';
            _postController.text = userDataMap['post'] ?? '';
            _districtController.text = userDataMap['district'] ?? '';
          });

          Fluttertoast.showToast(
            msg: "User data fetched successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          Fluttertoast.showToast(
            msg: "User does not exist.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Email not found in the database.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "No users found in the database.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // Update user data
  Future<void> _updateUserData(String uid) async {
    String phone = _phoneController.text.trim();
    String post = _postController.text.trim();
    String district = _districtController.text.trim();

    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$uid');

    try {
      await userRef.update({
        'phone': phone,
        'post': post,
        'district': district,
      });

      Fluttertoast.showToast(
        msg: "User data updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error updating user data: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      print('Error updating user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Padding(
        padding: const EdgeInsets.only(left:5,right: 16,bottom: 16),
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 50),
                child: CircleAvatar(

                  backgroundImage: AssetImage('assets/images/police3.jpg'),


                ),
              ),
              Container(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(

                        child: Text("Enter Gmail",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Container(
                        width: 300,
                        height:60,
                        child: TextField(
                          controller: _gmailController,
                          decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.mail,color: Colors.blue,),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton(
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
                onPressed: _fetchUserData,
                child: Text('Fetch User Data'),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(

                        child: Text("Phone",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Container(
                        width: 300,
                        height:50,
                        child: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.phone_android,color: Colors.blue,),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(

                        child: Text("Post",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Container(
                        width: 300,
                        height:50,
                        child: TextField(
                          controller: _postController,
                          decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.post_add,color: Colors.blue,),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),





              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(

                        child: Text("District",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Container(
                        width: 300,
                        height:50,
                        child: TextField(
                          controller: _districtController,
                          decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.location_on_outlined,color: Colors.blue,),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),







              SizedBox(height: 10),
              ElevatedButton(
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
                onPressed: () async {
                  // Fetch UID from email first to update
                  String email = _gmailController.text.trim();
                  DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
                  DatabaseEvent event = await usersRef.once();

                  if (event.snapshot.exists) {
                    Map<dynamic, dynamic> usersMap = event.snapshot.value as Map<dynamic, dynamic>;
                    String? uid;

                    // Find UID based on email
                    for (var entry in usersMap.entries) {
                      if (entry.value['email'] == email) {
                        uid = entry.key; // Get the UID
                        break;
                      }
                    }

                    if (uid != null) {
                      // Update user data using UID
                      await _updateUserData(uid);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Email not found.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  }
                },
                child: Text('Update User Data'),
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
  final TextEditingController _gmailController = TextEditingController();

  // Delete user data based on Gmail
  Future<void> _deleteUserData() async {
    String email = _gmailController.text.trim();

    // Reference to the users in the database
    DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
    DatabaseEvent event = await usersRef.once(); // Get all users at once

    if (event.snapshot.exists) {
      // Convert snapshot value to a map
      Map<dynamic, dynamic> usersMap = event.snapshot.value as Map<dynamic, dynamic>;
      String? uid;

      // Find UID based on email
      for (var entry in usersMap.entries) {
        if (entry.value['email'] == email) {
          uid = entry.key; // Get the UID
          break;
        }
      }

      if (uid != null) {
        // Delete user data using UID
        try {
          await usersRef.child(uid).remove();
          Fluttertoast.showToast(
            msg: "User data deleted successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Error deleting user data: $e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          print('Error deleting user data: $e');
        }
      } else {
        Fluttertoast.showToast(
          msg: "Email not found in the database.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "No users found in the database.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 50),
              child: CircleAvatar(

                backgroundImage: AssetImage('assets/images/police3.jpg'),


              ),
            ),
            Container(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(

                      child: Text("Enter Gmail",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 5),
                    child: Container(
                      width: 300,
                      height:60,
                      child: TextField(
                        controller: _gmailController,
                        decoration: InputDecoration(
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
                            prefixIcon: Icon(Icons.mail,color: Colors.blue,),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),








            SizedBox(height: 20),
            Container(
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
                onPressed: _deleteUserData,
                child: Center(child: Text('Delete User Data')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}