import 'package:flutter/material.dart';

import 'adminchallan.dart';
import 'asmatwhatsappchat.dart';
import 'bottomnavigation.dart';
import 'bottomnavigationrobbery2.dart';
import 'check.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin Dashboard')),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(  // Make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Separate each card
            buildPostingCard(context),
            SizedBox(height: 20),
            buildRobberyCard(context),
            SizedBox(height: 20),
            buildCriminalCard(context),
            SizedBox(height: 20),
            buildChatting(context), // Added the Chatting card
          ],
        ),
      ),
    );
  }

  Widget buildPostingCard(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.purpleAccent,
      shadowColor: Colors.black.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AdminDashboardd();
              },)
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: buildCardContent(
          'Posting',
          'assets/images/post.png',
          Icons.arrow_forward,
          Colors.purpleAccent,
        ),
      ),
    );
  }

  Widget buildRobberyCard(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.orangeAccent,
      shadowColor: Colors.black.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return bottomnavigationrobbery2();
              },)
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: buildCardContent(
          'Robbery Report',
          'assets/images/robber.png',
          Icons.arrow_forward,
          Colors.orangeAccent,
        ),
      ),
    );
  }

  Widget buildCriminalCard(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.greenAccent,
      shadowColor: Colors.black.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return FeetchDataPagee();
              },)
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: buildCardContent(
          'All Challans',
          'assets/images/challan.png',
          Icons.arrow_forward,
          Colors.greenAccent,
        ),
      ),
    );
  }

  Widget buildChatting(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Color(0xff1B0FBDFF),
      shadowColor: Colors.black.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ChatScreen(chatId: 'asmat');
              },)
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: buildCardContent(
          'Chatting',
          'assets/images/message.png',
          Icons.arrow_forward,
          Colors.blue,
        ),
      ),
    );
  }

  Widget buildCardContent(String title, String imagePath, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 30,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }
}

// A common layout widget that all pages can use
class CommonPageLayout extends StatelessWidget {
  final String title;
  final String content;

  CommonPageLayout({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
