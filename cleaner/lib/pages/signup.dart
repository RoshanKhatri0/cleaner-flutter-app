import 'package:cleaner/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email;
  late String password;
  late String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Create your account",
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 80,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Colors.purple.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.email)),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.password),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.password),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: Colors.purple,
                ),
                onPressed: () async {
                  if (!_isValidEmail(email)) {
                    // Show a SnackBar for invalid email format
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid email address.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    return;
                  }

                  if (password == confirmPassword) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Navigate to the login page after successful signup
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        if (e.code == 'email-already-in-use') {
                          // Show a SnackBar if the email is already in use
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('The email address is already in use.'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      }
                      print(e.toString());
                    }
                  } else {
                    // Show a SnackBar that passwords do not match
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Passwords do not match. Please try again.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Use a regular expression to check if the email is in a valid format
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
