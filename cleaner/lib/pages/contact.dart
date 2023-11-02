import 'package:cleaner/pages/thank_you.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Reference to the Firestore collection where you want to store contact info
  CollectionReference contactCollection =
      FirebaseFirestore.instance.collection('contacts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 80.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: Text(
                    'Your Contact Info',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              buildTextField(
                controller: nameController,
                labelText: 'Name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20.0),
              buildTextField(
                controller: emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              buildTextField(
                controller: phoneController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.0),
              buildTextField(
                controller: locationController,
                labelText: 'Location',
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (validateForm()) {
            // Save contact data to Firestore
            saveContactDataToFirestore();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ThankYou(),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey.shade200,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  bool validateForm() {
    // Validate all form fields
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        phoneController.text.isEmpty ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly.'),
        ),
      );
      return false;
    }
    return true;
  }

  void saveContactDataToFirestore() {
    // Create a map with the contact data
    Map<String, dynamic> contactData = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'location': locationController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Add the contact data to Firestore
    contactCollection.add(contactData).then((value) {
      print('Contact data added to Firestore with ID: ${value.id}');
    }).catchError((error) {
      print('Error adding contact data to Firestore: $error');
    });
  }
}
