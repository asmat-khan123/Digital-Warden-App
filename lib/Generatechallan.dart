import 'package:digital_warden_app/coachbus.dart';
import 'package:digital_warden_app/construction.dart';
import 'package:digital_warden_app/emergency.dart';
import 'package:digital_warden_app/flyingcoach.dart';
import 'package:digital_warden_app/jeepland.dart';
import 'package:digital_warden_app/mazda.dart';
import 'package:digital_warden_app/minitruck.dart';
import 'package:digital_warden_app/motercycle.dart';
import 'package:digital_warden_app/other.dart';
import 'package:digital_warden_app/pickup.dart';
import 'package:digital_warden_app/qingchi.dart';
import 'package:digital_warden_app/rickshaw.dart';
import 'package:digital_warden_app/texi.dart';
import 'package:digital_warden_app/tracter.dart';
import 'package:digital_warden_app/trailer.dart';
import 'package:digital_warden_app/truck.dart';
import 'package:digital_warden_app/van.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'nexthomepage.dart';

class GenereteChallan extends StatefulWidget{
  @override
  State<GenereteChallan> createState() => _GenereteChallanState();
}

class _GenereteChallanState extends State<GenereteChallan> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Generate Challan",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(right: 18,left: 15),
          width: 360,
          height: double.infinity,
        child:Center(
          child: GridView.count(crossAxisCount: 3,
          children: [
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Nexthomepage();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 10),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.car),
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
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CoachBus();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
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
                margin: EdgeInsets.only(top: 10,left: 8),
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
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return JeepLand();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 10),
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
                margin: EdgeInsets.only(top: 10,left: 8),
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
                margin: EdgeInsets.only(top: 10,left: 8),
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




            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QingChi();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 5),
                      child:Container(
                          width: 30,
                          height: 30,

                          child: Image(image: AssetImage("assets/images/rickshaw1.png"))),
                    ),
                    Column(
                      children: [
                        Text("Qing Chi"),
                        Text("Rickshaw")
                      ],
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
                  return Rickshaw();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(
//rickshaw2.png
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 5),
                      child:Container(
                          width: 35,
                          height: 35,

                          child: Image(image: AssetImage("assets/images/rickshaw.png"))),
                    ),
                    Text("Rickshaw"),
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
                  return Texi();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.taxi),
                    ),
                    Text("Taxi"),
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
                  return Tracter() ;
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.tractor),
                    ),
                    Text("Tractor/Trolley"),
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
                  return Van();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 5),
                      child:Container(
                          width: 35,
                          height: 35,

                          child: Image(image: AssetImage("assets/images/van1.png"))),
                    ),
                    Text("Van/APV"),  //van1.png
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
                  return Trailer();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.trailer),
                    ),
                    Text("Trailer"),
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
                  return Others();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 12),
                      child: Container(
                          width: 32,
                          height: 32,

                          child: Image(image: AssetImage("assets/images/others.png"))),
                    ),
                    Text("Other"),
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
                  return Mazda();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.truck),
                    ),
                    Text("Mazda"),
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
                  return MiniTruck();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.truck),
                    ),
                    Text("Mini Truck"),
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
                  return Truck();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Container(
                          width: 35,
                          height: 35,

                          child: Image(image: AssetImage("assets/images/truck.png"))),
                    ),
                    Text("Truck"),
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
                  return Emergency();
                },));


              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.ambulance),
                    ),
                    Column(
                      children: [
                        Text("Emergency"),
                        Text("Vehicle")
                      ],
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
                  return Construction();
                },));

              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 8),
                width: 100,
                height: 100,
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: FaIcon( FontAwesomeIcons.truckPickup),
                    ),
                    Column(
                      children: [
                        Text("Construction"),
                        Text("Machinery")
                      ],
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

          ],

          ),
        ),
        ),
      ),
    );

  }
}