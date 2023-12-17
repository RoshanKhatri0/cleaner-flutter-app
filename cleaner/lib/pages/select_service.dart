import 'package:cleaner/models/service.dart';
import 'package:cleaner/pages/cleaning.dart';
import 'package:cleaner/provider/cleaning_request_provider.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<CleaningRequestProvider>(
      builder: (context, cleaningProvider, child) {
        List<Service> services = cleaningProvider.services;
        int selectedService = cleaningProvider.selectedService;

        return Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      right: 20.0,
                      left: 20.0,
                    ),
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
            body: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                cleaningProvider.service.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      cleaningProvider.servicecontroller.text =
                          cleaningProvider.service[index];
                      print(cleaningProvider.servicecontroller.text);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                        Image.asset(cleaningProvider.servicespic[index],
                            height: 80),
                        const SizedBox(height: 20),
                        Text(
                          cleaningProvider.service[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
          // floatingActionButton: Builder(
          //   builder: (BuildContext context) {
          //     var cleaningProvider =
          //         Provider.of<CleaningRequestProvider>(context, listen: false);

          //     if (selectedService >= 0) {
          //       return FloatingActionButton(
          //         onPressed: () {
          //           String serviceName = services[selectedService].name;

          //           cleaningProvider.setServiceName(serviceName);

          //           // Clear previous data
          //           cleaningProvider.clearCleaningRequest();

          //           // Navigate to the Cleaning tab
          //           _tabController.animateTo(1);
          //         },
          //         backgroundColor: Colors.blue,
          //         child: const Icon(
          //           Icons.arrow_forward_ios,
          //           size: 20,
          //         ),
          //       );
          //     } else {
          //       return const FloatingActionButton(
          //         onPressed: null,
          //         backgroundColor: Colors.grey,
          //         child: Icon(
          //           Icons.arrow_forward_ios,
          //           size: 20,
          //         ),
          //       );
          //     }
          //   },
          // ),
        );
      },
    );
  }
}
