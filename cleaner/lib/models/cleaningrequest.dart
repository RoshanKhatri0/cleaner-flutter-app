import 'package:flutter/material.dart';

class CleaningRequest {
  String serviceName = '';
  List<String> selectedRooms = [];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedRepeat = '';
  String name = '';
  String email = '';
  String phone = '';
  String location = '';
}
