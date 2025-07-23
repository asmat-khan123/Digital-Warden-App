import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteUserDataPage extends StatefulWidget {
  @override
  State<DeleteUserDataPage> createState() => _DeleteUserDataPageState();
}

class _DeleteUserDataPageState extends State<DeleteUserDataPage> {
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
      appBar: AppBar(title: Center(child: Text('Delete User Data'))),
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








            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteUserData,
              child: Center(child: Text('Delete User Data')),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: DeleteUserDataPage()));
}
