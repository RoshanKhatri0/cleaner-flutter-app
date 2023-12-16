import 'package:cleaner/models/cleaningrequest.dart';
import 'package:cleaner/models/service.dart';
import 'package:flutter/material.dart';

class CleaningRequestProvider with ChangeNotifier {
  CleaningRequest cleaningRequest = CleaningRequest();

  String _serviceName = '';

  String getServiceName() => _serviceName;

  int selectedService = -1;
  List<Service> services = [
    Service('Initial Cleaning', 'assets/images/category1.png'),
    Service('Basic Cleaning', 'assets/images/category2.png'),
    Service('Deep cleaning', 'assets/images/category3.png'),
  ];

  void setServiceName(String serviceName) {
    cleaningRequest.serviceName = serviceName;
    notifyListeners();
  }

  List<String> _rooms = [
    'Living Room',
    'Bedroom',
    'Bathroom',
    'Kitchen',
    'Office'
  ];

  List<int> _selectedRooms = [];

  TextEditingController kitchenController = TextEditingController();

  // Getter for rooms
  List<String> get rooms => _rooms;

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
}
