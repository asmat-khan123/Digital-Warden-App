
import 'package:digital_warden_app/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatgpt.dart';


class AdmanLogin extends StatefulWidget{
  @override
  State<AdmanLogin> createState() => _AdmanLoginState();
}

class _AdmanLoginState extends State<AdmanLogin> {
  bool eyes=true;

  var admin=TextEditingController();




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:

      Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffB0BEC5),
        child: Center(
          child: Container(
            width: 350,
            height: 500,
            child: Card(

              elevation: 8,
              shadowColor: Colors.black,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30),
                    child: CircleAvatar(

                      backgroundImage: AssetImage('assets/images/police2.jpg'),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15),
                    child: Text("Admin Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: admin,
                      obscureText: eyes,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "enter password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,

                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,

                              )
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,),
                            onPressed: () {
                              setState(() {
                                eyes= !eyes;
                              });
                            },
                          ),
                          prefixIcon: Icon(Icons.lock_open,color: Colors.black,)
                      ),
                    ),
                  ),

Padding(
  padding: const EdgeInsets.only(top: 20),
  child: Container(
  width: 200,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.black45,
        minimumSize: Size(150, 50),
        maximumSize: Size(200, 50)
      ),
      onPressed: () {

            var a=154176;
            var admins=int.parse(admin.text.toString());
            if(admins !=null){
            if(admins==a)
            {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return AdminDashboard();
            },));
            }else{


            }

            }else{


            }


            }, child:  Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
  )



  ),
) ]
              ),

            ),
          ),
        ),
      ),



    );



  }


}
