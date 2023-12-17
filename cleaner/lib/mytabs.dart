import 'package:cleaner/pages/cleaning.dart';
import 'package:cleaner/pages/contact.dart';
import 'package:cleaner/pages/date_time.dart';
import 'package:cleaner/pages/login.dart';
import 'package:cleaner/pages/select_service.dart';
import 'package:cleaner/provider/cleaning_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CleaningRequestProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Cleaner App'),
          centerTitle: true,
          backgroundColor: Colors.purple,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Select Service'),
              Tab(text: 'Cleaning'),
              Tab(text: 'Date & Time'),
              Tab(text: 'Contact'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SelectService(),
            CleaningPage(),
            DateTimeSelector(),
            ContactPage(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            var cleaningProvider =
                Provider.of<CleaningRequestProvider>(context, listen: false);

            if (_tabController.index == 0 &&
                cleaningProvider.selectedService >= 0) {
              return FloatingActionButton(
                onPressed: () {
                  String serviceName = cleaningProvider
                      .services[cleaningProvider.selectedService].name;
                  cleaningProvider.setServiceName(serviceName);
                  _tabController.animateTo(1);
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            } else if (_tabController.index == 1) {
              return FloatingActionButton(
                onPressed: () {
                  // Get and set other cleaning-related data
                  // Example: cleaningProvider.addSelectedRoom('Living Room');
                  // Adjust the data and condition based on your use case
                  _tabController.animateTo(2);
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            } else if (_tabController.index == 2) {
              return FloatingActionButton(
                onPressed: () {
                  // Get and set date/time-related data
                  // Example: cleaningProvider.setSelectedDate(DateTime.now());
                  // Adjust the data and condition based on your use case
                  _tabController.animateTo(3);
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            } else if (_tabController.index == 3) {
              return FloatingActionButton(
                onPressed: () {
                  // Get and set contact-related data
                  // Example: cleaningProvider.setName('John Doe');
                  // Adjust the data and condition based on your use case

                  // Send data to Firebase (you need to implement this)
                  sendCleaningRequestToFirebase(
                    cleaningProvider
                        .services[cleaningProvider.selectedService].name,
                    cleaningProvider.cleaningRequest.selectedRooms,
                    cleaningProvider.cleaningRequest.selectedDate,
                    cleaningProvider.cleaningRequest.selectedTime,
                    cleaningProvider.cleaningRequest.selectedRepeat,
                    cleaningProvider.cleaningRequest.name,
                    cleaningProvider.cleaningRequest.email,
                    cleaningProvider.cleaningRequest.phone,
                    cleaningProvider.cleaningRequest.location,
                  );

                  // Clear the state
                  cleaningProvider.clearCleaningRequest();

                  // Move to the next tab or navigate to the ThankYou page
                  _tabController.animateTo(0);
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            } else {
              return const FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// The method to send data to Firebase (you need to implement this)
void sendCleaningRequestToFirebase(
  String serviceName,
  List<String> selectedRooms,
  DateTime selectedDate,
  TimeOfDay selectedTime,
  String selectedRepeat,
  String name,
  String email,
  String phone,
  String location,
) {
  // Reference to the Firestore collection where you want to store cleaning requests
  CollectionReference cleaningRequestsCollection =
      FirebaseFirestore.instance.collection('cleaning_requests');

  // Add the cleaning request to Firestore with a timestamp
  cleaningRequestsCollection.add({
    'service': {
      'name': serviceName,
      'timestamp': FieldValue.serverTimestamp(),
    },
    'selectedRooms': selectedRooms,
    'selectedDate': selectedDate,
    'selectedTime': selectedTime,
    'selectedRepeat': selectedRepeat,
    'contactInfo': {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
    },
    'timestamp': FieldValue.serverTimestamp(),
  }).then((_) {
    // Cleaning request added successfully
    print('Cleaning request added to Firestore');
  }).catchError((error) {
    // Handle errors here
    print('Error adding cleaning request to Firestore: $error');
  });
}
