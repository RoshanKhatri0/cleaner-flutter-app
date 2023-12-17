import 'package:cleaner/pages/date_time.dart';
import 'package:cleaner/provider/cleaning_request_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // List<String> pics = [
  //   'assets/images/living-room.png',
  //   'assets/images/bedroom.png',
  //   'assets/images/bath.png',
  //   'assets/images/kitchen.png',
  //   'assets/images/office.png',
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CleaningRequestProvider>(
      builder: (context, clean, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //   },
            //   child: Icon(Icons.arrow_forward),
            // ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Where do you want \ncleaned?',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Type of Rooms'),
                                  actions: List.generate(
                                      clean.typeofroom.length,
                                      (index) => ListTile(
                                            onTap: () {
                                              setState(() {
                                                clean.select =
                                                    clean.typeofroom[index];
                                                clean.nameofroom.text =
                                                    clean.typeofroom[index];
                                                print(clean.nameofroom.text);
                                                Navigator.pop(context);
                                              });
                                            },
                                            leading: Radio(
                                              value: clean.select,
                                              groupValue: clean.select,
                                              onChanged: (value) {
                                                setState(() {
                                                  clean.select =
                                                      value as String;
                                                });
                                              },
                                            ),
                                            title:
                                                Text(clean.typeofroom[index]),
                                          )),
                                );
                              });
                        },
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Image(
                                    height: 30,
                                    image: AssetImage(
                                        'assets/images/living-room.png')),
                                title: Text(clean.select),
                                trailing: IconButton(
                                    onPressed: () {
                                      clean.choose();
                                    },
                                    icon: Icon(clean.choosenumber
                                        ? Icons.arrow_drop_down_circle_rounded
                                        : Icons.arrow_circle_up_rounded)),
                              ),
                              if (clean.choosenumber)
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            'How Many Room Do You Want ?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(
                                              clean.rooms.length,
                                              (index) => GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        for (int i = 0;
                                                            i <
                                                                clean
                                                                    .selectedrooms
                                                                    .length;
                                                            i++) {
                                                          clean.selectedrooms[
                                                              i] = (i == index);
                                                          clean.numberofroom
                                                                  .text =
                                                              clean
                                                                  .rooms[index];
                                                          print(clean
                                                              .numberofroom
                                                              .text);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            clean.selectedrooms[
                                                                    index]
                                                                ? Colors.orange
                                                                : Colors.orange[
                                                                    100],
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        clean.rooms[index],
                                                        style: TextStyle(
                                                            color:
                                                                clean.selectedrooms[
                                                                        index]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                      )),
                                                    ),
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Image(
                                height: 30,
                                image: AssetImage(
                                    'assets/images/living-room.png')),
                            title: Text(clean.bedroom),
                            trailing: IconButton(
                                onPressed: () {
                                  clean.selectbedrooms();
                                },
                                icon: Icon(clean.selectbedroom
                                    ? Icons.arrow_drop_down_circle_rounded
                                    : Icons.arrow_circle_up_rounded)),
                          ),
                          if (clean.selectbedroom)
                            Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        'How Many Bedroom Do You Want ?'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          clean.bedrooms.length,
                                          (index) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            clean.selectedbeds
                                                                .length;
                                                        i++) {
                                                      clean.selectedbeds[i] =
                                                          (i == index);
                                                      clean.numberofbedroom
                                                              .text =
                                                          clean.bedrooms[index];
                                                      print(clean
                                                          .numberofbedroom
                                                          .text);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: clean
                                                            .selectedbeds[index]
                                                        ? Colors.orange
                                                        : Colors.orange[100],
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    clean.bedrooms[index],
                                                    style: TextStyle(
                                                        color:
                                                            clean.selectedbeds[
                                                                    index]
                                                                ? Colors.white
                                                                : Colors.black),
                                                  )),
                                                ),
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(
                        clean.others.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              clean.checked[index] = !clean
                                  .checked[index]; // Toggle the checked state

                              if (clean.checked[index]) {
                                clean.expensescontroller.text =
                                    clean.others[index];
                                print(clean.expensescontroller.text);
                              } else {
                                // Handle deselection if needed
                              }
                            });
                          },
                          child: Card(
                            child: ListTile(
                              trailing: Icon(
                                clean.checked[index] ? Icons.check : null,
                              ),
                              leading: Image(
                                height: 30,
                                image: AssetImage(clean.pics[index]),
                              ),
                              title: Text(clean.others[index]),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  // Widget room(List room, int index, CleaningRequestProvider cleaningProvider) {
  //   return Consumer<CleaningRequestProvider>(
  //     builder: (context, clean, child) {
  //       return ListView.builder(itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text(rooms[index]),
  //         );
  //       });
  //     },
  //   );
}
// Text(
//                       'Where do you want \ncleaned?',
//                       style: TextStyle(
//                         fontSize: 35,
//                         color: Colors.grey.shade900,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
 