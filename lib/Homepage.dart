import 'package:digital_warden_app/Generatechallan.dart';
import 'package:digital_warden_app/coachbus.dart';
import 'package:digital_warden_app/flyingcoach.dart';
import 'package:digital_warden_app/jeepland.dart';
import 'package:digital_warden_app/motercycle.dart';
import 'package:digital_warden_app/nexthomepage.dart';
import 'package:digital_warden_app/pickup.dart';

import 'package:digital_warden_app/robberyfetchdata.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminlogin.dart';
import 'asmat2chattingscreen.dart';

import 'check.dart';
import 'main.dart';


class Homepage extends StatefulWidget{

  final String name;
  final String post;
final String district;
  Homepage({required this.name, required this.post,required this.district});


  @override
  State<Homepage> createState() => HomepageState();




}

class HomepageState extends State<Homepage> {
  final TextEditingController checkIdController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Function to fetch data from Firebase based on ID
  void _fetchUserById() async {
    String checkId = checkIdController.text.trim();

    if (checkId.isEmpty) {
      _showMessage("Error: Please enter an ID.");
      return;
    }

    try {
      // Fetch the reference from Firebase
      DatabaseReference recordRef = _database.child('Records/$checkId');
      DatabaseEvent event = await recordRef.once();

      // Check if data exists
      if (event.snapshot.exists && event.snapshot.value is Map) {
        Map<String, dynamic> userData = Map<String, dynamic>.from(event.snapshot.value as Map);
        String userName = userData['name'] ?? 'No Name';
        String userPhone = userData['phone'] ?? 'No Phone';
        _showMessage("Name: $userName, Phone: $userPhone");
      } else {
        _showMessage("No record found for ID: $checkId.");
      }
    } catch (e) {
      _showMessage("Error: An error occurred: $e");
    }
  }

  // Show the message in a SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 5), // Optional timeout for the SnackBar

      ),
    );
  }

  late String displayedName;
late String posting;
late String districts;
  @override
  void initState() {
    super.initState();
    _fetchChallanCount();
    // Initialize displayedName with the passed name
  setState(() {
    displayedName = widget.name.toString();
    posting= widget.post.toString();
    districts = widget.district.toString();
  });
  }
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  int totalChallans = 0; // Variable to hold the total number of challans

  // Function to count challans
  Future<int> _countChallans() async {
    try {
      final DatabaseEvent event = await database.child('Records').once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> recordsMap = event.snapshot.value as Map<dynamic, dynamic>;
        return recordsMap.length; // Number of challans
      } else {
        return 0; // No records found
      }
    } catch (e) {
      print('Error counting challans: $e');
      return 0;
    }
  }

  // Function to fetch challan count and update UI
  void _fetchChallanCount() async {
    int challanCount = await _countChallans();


    setState(() {
      totalChallans = challanCount; // Update the state with the fetched count
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children:[
            UserAccountsDrawerHeader(

              accountName: Text("PUNJAB",style: TextStyle(fontWeight:  FontWeight.bold),),
              accountEmail: Text("HIGHWAY PATROL",style: TextStyle(color: Colors.yellowAccent),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Image.asset('assets/images/police2.jpg'),),
            ),
              decoration: BoxDecoration(
                color: Color(0xFF4D3B2D),
              //  image: DecorationImage(image: AssetImage('assets/images/police4.jpg'),fit: BoxFit.fill)
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.fileSignature),
              title: Text('My Challan'),
              onTap: () {

Navigator.push(context, MaterialPageRoute(builder: (context) {
  return  FeetchDataPageaa() ;
},));


              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.handHoldingDollar),
              title: Text('Robbery Report'),
              onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) {
  return RobberyReportPage();
},));


              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.userTie),
              title: Text('Admin Login'),

              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => AdmanLogin()));

              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidCommentDots),
              title: Text('Message'),
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  ChatScreen2(chatId: 'asmat') ;
                },));


              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout'),
              onTap: () {

              logout();

              },
            ),
          ],
        ),
      ),
      appBar:AppBar(
        title: Text("Digital Warden by PHP",style: TextStyle(fontWeight: FontWeight.bold),),
      ) ,
      body:Padding(

        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Center(
                  child: Container(
                    width: 320,
                    height: 120,
                child: Row(
                          children: [
                            Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Container(
                  margin: EdgeInsets.only(left:0),
                  width: 150,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 8),
                        child: Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(

                  child: ClipOval(child: Image.asset('assets/images/logo.png'),),
                  ),
                        ),
                      ),
                     Padding(
                       padding: const EdgeInsets.only(top: 0,left: 15),
                       child: Text("PUNJAB",style: TextStyle(fontWeight: FontWeight.bold,fontSize:14 ,color: Colors.white),),
                     ),
                      Padding(
                        padding: const EdgeInsets.only(top:0,left: 22),
                        child: Text("HIGHWAY PATROL",style: TextStyle(color: Colors.yellow,fontSize:10 ),),
                      )




                    ],
                  ),
                ),
                            ),
                            Container(

                margin:  EdgeInsets.only(left: 0),
                width: 140,

                child: Column(


                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 10,right: 14),
                      child: Text(" $displayedName 469/PHP",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18,right: 67,bottom: 4),
                      child: Text("Duty Location",style: TextStyle(fontSize: 11,color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Text("District: ",style:TextStyle(color: Colors.yellow,fontSize: 11,fontWeight: FontWeight.bold) ,),
                        Text("$districts",style: TextStyle(fontSize: 11,color: Colors.white,fontWeight: FontWeight.bold)),

                      ],
                    ),

                    Row(
                      children: [
                        Text("Post: ",style:TextStyle(color: Colors.yellow,fontSize: 13,fontWeight: FontWeight.bold) ,),
                        Text("$posting",style: TextStyle(fontSize: 11,color: Colors.white,fontWeight: FontWeight.bold),),

                      ],
                    ),


                  ],
                ),
                            )

                          ],
                ),
                             decoration: BoxDecoration(
                 color:Color(0xFF4D3B2D), // Olive-Brown

                   borderRadius: BorderRadius.circular(8),
                             ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 160,top: 6),
                      child: Text("Dashboard",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text("Today's stats",style: TextStyle(fontSize: 12),),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                 Container(
                   width: 96,
                   height: 100,
                   margin: EdgeInsets.only(left: 15,top: 20),
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 17),
                         child: Text("$totalChallans",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                       ),
                       Text("Total",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                       Text("Challan",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                     ],
                   ),
                   decoration: BoxDecoration(
                     color: Colors.amber,
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
                  Container(
                    width: 96,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                    height: 100,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text("$totalChallans",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ),
                        Text("Paid" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text("Challan",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 96,
                    height: 100,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 17,),
                          child: Text("0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        Text("Unpaid",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text("Challan",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15,top: 10),
                  width: 308,
                  height: 50,
                  child: Center(child: Text("Axle Load Management",style: TextStyle(fontSize: 15),),),

                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)
                  ),

                )
              ],
            ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 150,top: 6),
                    child: Text("Generate Challan",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: InkWell(
                              onTap: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GenereteChallan();
          },));







                              },

                              child: Text("View All",style: TextStyle(fontSize: 12,color: Colors.black87),)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 44,
                          height: 1,
                          color: Colors.black,
                        )
                      ],
                    )

                  ),
                ],
              ),

          Row(
            children: [
              InkWell(
                onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Nexthomepage();
          },));


                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Nexthomepage();
                    },));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20,left: 13),
                    width: 100,
                    height: 100,
                    child: Column(

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                          child: FaIcon( FontAwesomeIcons.carOn),
                        ),
                        Text("Car"),
                      ],

                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(width: 1,color: Colors.black26),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CoachBus();
                  },));

                },
                child: Container(
                  margin: EdgeInsets.only(top: 20,left: 8),
                  width: 100,
                  height: 100,
                  child: Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: FaIcon( FontAwesomeIcons.bus),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Text("Coach/Bus Coaster"),
                      ),
                    ],

                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black26),
                  ),
                ),
              ),
              InkWell(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FlyingCoach();
                  },));

                },
                child: Container(
                  margin: EdgeInsets.only(top: 20,left: 8),
                  width: 100,
                  height: 100,
                  child: Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: FaIcon( FontAwesomeIcons.busSimple),
                      ),
                      Text("Flying Coach"),
                    ],

                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black26),
                  ),
                ),
              ),
            ],
          ),
              Row(
                children: [
                  InkWell(
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return JeepLand();
                      },));

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 13),
                      width: 100,
                      height: 100,
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: FaIcon( FontAwesomeIcons.car),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text("Jeep/Land Cruiser"),
                          ),
                        ],

                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.black26),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Motercycle();
                      },));

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 8),
                      width: 100,
                      height: 100,
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: FaIcon( FontAwesomeIcons.motorcycle),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Text("Motorbike"),
                          ),
                        ],

                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.black26),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Pickup();
                      },));

                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 8),
                      width: 100,
                      height: 100,
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: FaIcon( FontAwesomeIcons.truckPickup),
                          ),
                          Text("Pickup"),
                        ],

                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(width: 1,color: Colors.black26),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: Text("Check Payment Status (PSID)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                  )
                ],
              ),

          Row(
            children: [
              Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: 185,
            height: 45,


            child: TextField(
              controller: checkIdController,
          keyboardType: TextInputType.number,
              decoration: InputDecoration(
          hintText: "4098xxxxxxxxxxxxx",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Colors.black45,
              width: 1
            )

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.black45,
                        width: 1
                    )
                )

              ),

            ),
          ),
              ),
             InkWell(
               onTap: () {
           _fetchUserById();


               },
               child: Container(
           margin: EdgeInsets.only(top: 10,left: 10),
           width: 120,
           height: 45,
           child: Center(child: Text("Check status")),
           decoration: BoxDecoration(
             borderRadius:BorderRadius.circular(15),
              color: Colors.amber
           ),

               ),
             )
            ],
          )







            ],
          ),
        ),
      )


    );


  }

  void logout() async{
    var preff=await SharedPreferences.getInstance();
    preff.setBool('isLoggedIn', false);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
      return MyHomePage(title: 'Flutter Login');
    },));

  }


}