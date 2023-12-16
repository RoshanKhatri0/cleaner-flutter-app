// my_tabs.dart
import 'package:cleaner/pages/cleaning.dart';
import 'package:cleaner/pages/contact.dart';
import 'package:cleaner/pages/date_time.dart';
import 'package:flutter/material.dart';
import 'pages/select_service.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cleaner App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Select Service'),
            Tab(text: 'Cleaning'),
            Tab(text: 'DateTime'),
            Tab(text: 'Contacts'),
          ],
        ),
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
    );
  }
}
