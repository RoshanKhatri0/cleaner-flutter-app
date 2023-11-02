import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cleaner/provider/auth.dart';
import 'package:cleaner/pages/date_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  List<dynamic> _rooms = [
    ['Living Room', 'assets/images/living-room.png', Colors.red, 0],
    ['Bedroom', 'assets/images/bedroom.png', Colors.orange, 1],
    ['Bathroom', 'assets/images/bath.png', Colors.blue, 1],
    ['Kitchen', 'assets/images/kitchen.png', Colors.purple, 0],
    ['Office', 'assets/images/office.png', Colors.green, 0]
  ];
  List<String> rooms = [
    'Living Room',
    'Bedroom',
    'Bathroom',
    'Kitchen',
    'Office'
  ];

  List<int> _selectedRooms = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: _selectedRooms.length > 0
              ? FloatingActionButton(
                  onPressed: () {
                    // Save selected rooms data to Firestore
                    saveSelectedRoomsToFirestore(value);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DateTimeSelector(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_selectedRooms.length}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 2),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                  backgroundColor: Colors.blue,
                )
              : null,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Where do you want \ncleaned?',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return room(_rooms[index], index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  room(List room, int index) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.kitchencontroller.text = rooms[index];
            setState(() {
              if (_selectedRooms.contains(index))
                _selectedRooms.remove(index);
              else
                _selectedRooms.add(index);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            margin: EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: _selectedRooms.contains(index)
                  ? room[2].shade50.withOpacity(0.5)
                  : Colors.grey.shade100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          room[1],
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          room[0],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Spacer(),
                    _selectedRooms.contains(index)
                        ? Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.greenAccent.shade100.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 20,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                (_selectedRooms.contains(index) && room[3] >= 1)
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "How many ${room[0]}s?",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 45,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          room[3] = index + 1;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        padding: EdgeInsets.all(10.0),
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: room[3] == index + 1
                                              ? room[2].withOpacity(0.5)
                                              : room[2]
                                                  .shade200
                                                  .withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to save selected rooms to Firestore
  Future<void> saveSelectedRoomsToFirestore(AuthProvider authProvider) async {
    try {
      // Firestore reference
      CollectionReference selectedRoomsCollection =
          FirebaseFirestore.instance.collection('selected_rooms');

      // Save selected rooms data to Firestore
      for (int index in _selectedRooms) {
        await selectedRoomsCollection.add({
          'roomName': _rooms[index][0],
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving selected rooms data to Firestore: $e');
    }
  }
}
