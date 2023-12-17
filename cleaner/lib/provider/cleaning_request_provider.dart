import 'dart:math';

import 'package:cleaner/models/cleaningmodel.dart';
import 'package:cleaner/models/cleaningrequest.dart';
import 'package:cleaner/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CleaningRequestProvider with ChangeNotifier {
  CleaningRequest cleaningRequest = CleaningRequest();
  TextEditingController nameofroom = TextEditingController();
  TextEditingController numberofroom = TextEditingController();
  TextEditingController kitchen = TextEditingController();
  TextEditingController office = TextEditingController();
  TextEditingController numberofbedroom = TextEditingController();
  TextEditingController expensescontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController servicecontroller = TextEditingController();
  String _serviceName = '';

  String getServiceName() => _serviceName;
  bool choosenumber = false;
  bool selectedroom = false;
  bool selected = false;
  bool selectbedroom = false;
  bool selectedbedroom = false;
  List<bool> selectedrooms = [
    true,
    false,
    false,
    false,
  ];
  List<bool> selectedbeds = [
    true,
    false,
    false,
    false,
  ];
  List<bool> checked = [true, false, false];
  String select = 'Select Room';
  String bedroom = 'Select Bedroom';

  List<String> rooms = [
    '1',
    '2',
    '3',
    '4',
  ];
  List<String> bedrooms = [
    '1',
    '2',
    '3',
    '4',
  ];
  List<String> typeofroom = [
    'Living Room',
    'Hall Room',
  ];
  void choose() {
    choosenumber = !choosenumber;
    notifyListeners();
  }

  void selectroom() {
    selectedroom = !selectedroom;
    notifyListeners();
  }

  void selectbedrooms() {
    selectbedroom = !selectbedroom;
    notifyListeners();
  }

  int selectedService = -1;
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
  List<String> servicespic = [
    'assets/images/category1.png',
    'assets/images/category2.png',
    'assets/images/category3.png'
  ];
  List<String> pics = [
    'assets/images/bath.png',
    'assets/images/kitchen.png',
    'assets/images/office.png'
  ];

  void setServiceName(String serviceName) {
    cleaningRequest.serviceName = serviceName;
    notifyListeners();
  }

  List<String> others = ['Bathroom', 'Kitchen', 'Office'];

  List<int> _selectedRooms = [];

  TextEditingController kitchenController = TextEditingController();

  // Getter for rooms

  // Getter for selected rooms
  List<int> get selectedRooms => _selectedRooms;

  // Method to add a selected room
  void addSelectedRoom(int index) {
    _selectedRooms.add(index);
    notifyListeners();
  }

  // Method to remove a selected room
  void removeSelectedRoom(int index) {
    _selectedRooms.remove(index);
    notifyListeners();
  }

  void setSelectedDate(String date) {
    // Convert the date string to DateTime
    DateTime selectedDate = DateTime.parse(date);

    // Assign the selected date to the cleaning request
    cleaningRequest.selectedDate = selectedDate;

    // Notify listeners
    notifyListeners();
  }

  void setSelectedTime(String time) {
    // Convert the time string to TimeOfDay
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.parse(time));

    // Assign the selected time to the cleaning request
    cleaningRequest.selectedTime = selectedTime;

    // Notify listeners
    notifyListeners();
  }

  void setSelectedRepeat(String repeat) {
    // Assign the selected repeat option to the cleaning request
    cleaningRequest.selectedRepeat = repeat;

    // Notify listeners
    notifyListeners();
  }

  void setName(String name) {
    cleaningRequest.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    cleaningRequest.email = email;
    notifyListeners();
  }

  void setPhone(String phone) {
    cleaningRequest.phone = phone;
    notifyListeners();
  }

  void setLocation(String location) {
    cleaningRequest.location = location;
    notifyListeners();
  }

  void clearCleaningRequest() {
    cleaningRequest = CleaningRequest();
    notifyListeners();
  }

  bool loading = false;
  Cleaningmodel? _cleaningModel;

  Cleaningmodel? get cleanmodel => _cleaningModel;

  Future<void> addInformation(
      String servicename,
      String roomName,
      String other,
      String name,
      String date,
      String time,
      String location,
      String email,
      String numberofroom,
      String phonenumber,
      String numberofbedroom) async {
    loading = true;
    notifyListeners();

    try {
      _cleaningModel = Cleaningmodel(
          servicename: servicename,
          roomname: roomName,
          other: other,
          name: name,
          date: date,
          time: time,
          location: location,
          email: email,
          numberofroom: numberofroom,
          phonenumber: phonenumber,
          numberofbedroom: numberofbedroom);

      Map<String, dynamic> cleaningData = _cleaningModel!.tojson();
      var addToFirestore = await FirebaseFirestore.instance
          .collection('cleaner') // Correct collection name
          .add(cleaningData);

      print('Added Document ID: ${addToFirestore.id}');
    } catch (e) {
      print('Error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
