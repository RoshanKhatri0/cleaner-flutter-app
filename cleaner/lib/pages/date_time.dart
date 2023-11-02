import 'package:cleaner/pages/contact.dart';
import 'package:cleaner/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({Key? key}) : super(key: key);

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  String selectedRepeat = 'Weekly'; // Default repeat option
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  // Function to add date, time, repeat, and timestamp to Firestore
  void addDateTimeToFirestore(String date, String time, String repeat) {
    // Reference to the Firestore collection where you want to store data
    CollectionReference dateTimeCollection =
        FirebaseFirestore.instance.collection('dateTime');

    // Add the data to Firestore with a timestamp
    dateTimeCollection.add({
      'date': date,
      'time': time,
      'repeat': repeat,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      // Data added successfully
      print('Data added to Firestore');
    }).catchError((error) {
      // Handle errors here
      print('Error adding data to Firestore: $error');
    });
  }

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
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 80.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Select Date and \nTime',
                        style: TextStyle(
                          fontSize: 38,
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
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${selectedDate.toLocal()}'.split(' ')[0],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${selectedTime.format(context)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Repeat',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Repeat Options Section
                  Column(
                    children: <Widget>[
                      RadioListTile(
                        title: Text('One Time'),
                        value: 'One Time',
                        groupValue: selectedRepeat,
                        onChanged: (value) {
                          setState(() {
                            selectedRepeat = value as String;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Weekly'),
                        value: 'Weekly',
                        groupValue: selectedRepeat,
                        onChanged: (value) {
                          setState(() {
                            selectedRepeat = value as String;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Bi-weekly'),
                        value: 'Bi-weekly',
                        groupValue: selectedRepeat,
                        onChanged: (value) {
                          setState(() {
                            selectedRepeat = value as String;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Monthly'),
                        value: 'Monthly',
                        groupValue: selectedRepeat,
                        onChanged: (value) {
                          setState(() {
                            selectedRepeat = value as String;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Bi-monthly'),
                        value: 'Bi-monthly',
                        groupValue: selectedRepeat,
                        onChanged: (value) {
                          setState(() {
                            selectedRepeat = value as String;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Get the selected date, time, and repeat values
              String selectedDateString =
                  '${selectedDate.toLocal()}'.split(' ')[0];
              String selectedTimeString = '${selectedTime.format(context)}';
              String selectedRepeatValue = selectedRepeat;

              // Add the data to Firestore
              addDateTimeToFirestore(
                selectedDateString,
                selectedTimeString,
                selectedRepeatValue,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
            child: Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}
