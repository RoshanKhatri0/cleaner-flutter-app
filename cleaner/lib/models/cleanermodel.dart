class CleanerModel {
  String name;
  String email;
  String phonenumber;
  String location;
  String serviceName;
  String place;

  CleanerModel({
    required this.location,
    required this.name,
    required this.phonenumber,
    required this.email,
    required this.serviceName,
    required this.place,
  });
  tojson() {
    return {
      "Category": place,
      "Service": serviceName,
      "Location": location,
      "Date": name,
      "PhoneNumber": phonenumber,
    };
  }
}
