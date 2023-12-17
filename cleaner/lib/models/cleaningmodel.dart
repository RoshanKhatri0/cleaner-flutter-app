class Cleaningmodel {
  String servicename;
  String roomname;
  String numberofroom;
  String numberofbedroom;
  String other;
  String name;
  String date;
  String time;
  String email;
  String phonenumber;
  String location;

  Cleaningmodel({
    required this.numberofbedroom,
    required this.servicename,
    required this.roomname,
    required this.numberofroom,
    required this.name,
    required this.date,
    required this.other,
    required this.email,
    required this.location,
    required this.phonenumber,
    required this.time,
  });
  tojson() {
    return {
      'Service': servicename,
      'Room Name': roomname,
      'Cleaning Space': other,
      'name': name,
      'date': date,
      'location': location,
      'Phone Number': phonenumber,
      'time': time,
      'Numberofrooms': numberofroom,
      'NumberofBedrooms': numberofbedroom,
      'email': email
    };
  }
}
