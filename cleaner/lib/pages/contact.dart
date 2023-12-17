// contact_page.dart

import 'package:cleaner/provider/cleaning_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<CleaningRequestProvider>(
      builder: (context, cleaningProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // Get and set contact-related data
          //     cleaningProvider.setName(nameController.text);
          //     cleaningProvider.setEmail(emailController.text);
          //     cleaningProvider.setPhone(phoneController.text);
          //     cleaningProvider.setLocation(locationController.text);

          //     // Move to the next tab (DateTimeSelector)
          //     cleaningProvider.setTabIndex(2);
          //   },
          //   child: Icon(Icons.arrow_forward),
          // ),
        );
      },
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
}
