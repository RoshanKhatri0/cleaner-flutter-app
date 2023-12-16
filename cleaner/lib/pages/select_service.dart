import 'package:cleaner/models/service.dart';
import 'package:cleaner/pages/cleaning.dart';
import 'package:cleaner/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SelectService extends StatefulWidget {
  SelectService({Key? key});

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // Function to add selected service to Firestore
  void addServiceToFirestore(String serviceName) {
    // Reference to the Firestore collection where you want to store services
    CollectionReference servicesCollection =
        FirebaseFirestore.instance.collection('services');

    // Add the selected service to Firestore with a timestamp
    servicesCollection.add({
      'name': serviceName,
      'timestamp': FieldValue.serverTimestamp(),
      // Add other properties as needed
    }).then((_) {
      // Service added successfully
      print('Service added to Firestore');
    }).catchError((error) {
      // Handle errors here
      print('Error adding service to Firestore: $error');
    });
  }

  List<Service> services = [
    Service('Initial Cleaning', 'assets/images/category1.png'),
    Service('Basic Cleaning', 'assets/images/category2.png'),
    Service('Deep cleaning', 'assets/images/category3.png'),
  ];
  List<String> service = [
    'Initial Cleaning',
    'Basic Cleaning',
    'Deep cleaning'
  ];
  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 80.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Which service \ndo you need?',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: service.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedService == index) {
                              selectedService = -1;
                            } else {
                              selectedService = index;
                            }
                            value.initialcleaning.text = service[index];
                            print('controller${value.initialcleaning.text}');
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: selectedService == index
                                ? Colors.blue.shade50
                                : Colors.grey.shade200,
                            border: Border.all(
                              color: selectedService == index
                                  ? Colors.blue
                                  : Colors.blue.withOpacity(0),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(services[index].imageURL, height: 80),
                              const SizedBox(height: 20),
                              Text(
                                services[index].name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              if (selectedService >= 0) {
                return FloatingActionButton(
                  onPressed: () {
                    // Get the name of the selected service
                    String serviceName = services[selectedService].name;

                    // Add the selected service to Firestore
                    addServiceToFirestore(
                      serviceName,
                    );

                    _tabController.animateTo(4);
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
        );
      },
    );
  }
}
