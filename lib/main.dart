import 'package:digital_warden_app/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool passwordView = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 15),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Login now with your Registered", style: TextStyle(color: Colors.black54)),
              const Text("Username and Password", style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 23),
              SizedBox(
                width: 400,

                child: Column(
                  children: [
                    _buildTextField("Gmail", emailController, Icons.email, false),
                    const SizedBox(height: 20),
                    _buildTextField("Password", passwordController, Icons.lock, true),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () => _login(),
                      child: Container(
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: _resetPassword,
                      child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5),
          child: SizedBox(
            width: 300,
            height: 60,
            child: TextField(
              controller: controller,
              obscureText: isPassword ? passwordView : false,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(icon, color: Colors.orange),
                suffixIcon: isPassword
                    ? IconButton(
                  onPressed: () => setState(() => passwordView = !passwordView),
                  icon: const Icon(Icons.remove_red_eye, color: Colors.orange),
                )
                    : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please input correct data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        await fetchUserData(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        errorMessage = "Gmail or Password is incorrect";
      } else {
        errorMessage = e.message ?? "Login failed";
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$uid');
      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic> userData = snapshot.value as Map<dynamic, dynamic>;

        final String name = userData['name'] ?? "Unknown";
        final String post = userData['post'] ?? "Unknown";
        final String district = userData['district'] ?? "Unknown";

        // Save to SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        await prefs.setString('name', name);
        await prefs.setString('post', post);
        await prefs.setString('district', district);

        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(name: name, post: post, district: district),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "User data not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching user data: $e");
    }
  }

  Future<void> _resetPassword() async {
    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email first");
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Fluttertoast.showToast(msg: "Password reset email sent");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }
}
