import 'package:cleaner/pages/date_time.dart';
import 'package:cleaner/provider/cleaning_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<CleaningRequestProvider>(
      builder: (context, cleaningProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // Call your provider method here for data handling or navigation
          //     // Example: cleaningProvider.addSelectedRoom(0);
          //     // Adjust the data and condition based on your use case

          //     // For demonstration purposes, I'll just navigate to the next page
          //     cleaningProvider.setTabIndex(cleaningProvider.tabIndex + 1);
          //   },
          //   child: Icon(Icons.arrow_forward),
          // ),
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
                  return room(_rooms[index], index, cleaningProvider);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget room(List room, int index, CleaningRequestProvider cleaningProvider) {
    return GestureDetector(
      onTap: () {
        cleaningProvider.kitchenController.text = cleaningProvider.rooms[index];
        setState(() {
          cleaningProvider.addSelectedRoom(index);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cleaningProvider.selectedRooms.contains(index)
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                cleaningProvider.selectedRooms.contains(index)
                    ? Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.3),
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
            (cleaningProvider.selectedRooms.contains(index) && room[3] >= 1)
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
                              itemBuilder: (BuildContext context, int index) {
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
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: room[3] == index + 1
                                          ? room[2].withOpacity(0.5)
                                          : room[2].shade200.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.white),
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
  }
}
