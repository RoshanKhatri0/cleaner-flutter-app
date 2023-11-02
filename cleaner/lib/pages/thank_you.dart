import 'package:cleaner/pages/select_service.dart';
import 'package:flutter/material.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Thank you for choosing cleaner for your cleaning requirements.',
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
            body: Container(
              margin: EdgeInsets.only(top: 100),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Our team will contact you via email for the receipt of payment \nand our cleaning professionals will visit your home soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectService(),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
