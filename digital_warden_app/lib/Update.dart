import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Update extends StatefulWidget{
  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
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

  // Fetch user data based on Gmail

@override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Center(child: Text("Update")),
     ),
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
                      height:50,
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