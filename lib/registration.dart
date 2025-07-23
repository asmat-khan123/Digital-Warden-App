

import 'package:digital_warden_app/Update.dart';
import 'package:digital_warden_app/deletee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'construction.dart';
import 'main.dart';

class Registration extends StatefulWidget{
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {


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

     appBar: AppBar(
       title: Center(child: Padding(
         padding: const EdgeInsets.only(right: 90),
         child: Text("Registration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
       )),

     ),


      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children:[
            UserAccountsDrawerHeader(

              accountName: Text("PUNJAB",style: TextStyle(fontWeight:  FontWeight.bold),),
              accountEmail: Text("HIGHWAY PATROL"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Image.asset('assets/images/police2.jpg'),),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue
                //  image: DecorationImage(image: AssetImage('assets/images/police4.jpg'),fit: BoxFit.fill)
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Update'),
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Update();
              },));



              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {

Navigator.push(context, MaterialPageRoute(builder: (context) {
  return DeleteUserDataPage();
}
,));

              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Robber Report'),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Construction();
                }
                  ,));

              },
            ),
          ],
        ),
      ),














      body: Container(

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
                        controller: phonee,
                        keyboardType: TextInputType.number,
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
                      height:50,
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
                        keyboardType: TextInputType.number,
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
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(onPressed: () async{
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return MyHomePage(title: 'Flutter Demo Home Page');
                          },));

                        }, child: Text("Back",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(onPressed: () async{
                          String email =gmail.text.toString() ;
                          String password = passwords.text.toString();
                          String name = namee.text.toString();
                          String phone = phonee.text.toString();
                          String fname = fnamee.text.toString();
                          String cnic = cnicc.text.toString();
                          String posts=post.text.toString();
                          String districts=district.text.toString();
                          // Register user
                          await registerUser(email, password, name, phone, fname, cnic,posts,districts);


                        }, child: Text("Submit",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
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
