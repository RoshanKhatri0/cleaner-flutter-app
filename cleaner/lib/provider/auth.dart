import 'package:cleaner/models/cleanermodel.dart';
import 'package:cleaner/pages/thank_you.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  //categories
  TextEditingController initialcleaning = TextEditingController();
  TextEditingController basicontroller = TextEditingController();
  TextEditingController deepcleaningcontroller = TextEditingController();
  //placescontroller
  TextEditingController livingcontroller = TextEditingController();
  TextEditingController bedroomcontroller = TextEditingController();
  TextEditingController bathroomcontroller = TextEditingController();
  TextEditingController kitchencontroller = TextEditingController();
  TextEditingController officecontroller = TextEditingController();
  //datetimecontroller
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController repeatcontroller = TextEditingController();

  CleanerModel? _cleanerModel;
  CleanerModel? get clean => _cleanerModel;
  bool loadingclean = false;
  Future<void> addUserInformation(String name, String email, String phone,
      String location, String service, String place, context) async {
    loadingclean = true;
    notifyListeners();
    try {
      CleanerModel cleanerModel = CleanerModel(
          location: location,
          name: name,
          phonenumber: phone,
          email: email,
          serviceName: service,
          place: place);

      Map<String, dynamic> cleanroom = cleanerModel.tojson();
      var requested =
          await FirebaseFirestore.instance.collection('clean').add(cleanroom);

      print('rrr$requested');

      _cleanerModel = CleanerModel(
          location: location,
          name: name,
          phonenumber: phone,
          email: email,
          serviceName: service,
          place: place);
      if (_cleanerModel != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data Stored')));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThankYou(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data Stored')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      loadingclean = false;
      notifyListeners();
    }
  }
}
