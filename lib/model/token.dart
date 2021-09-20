class UserAsigned {
  String provision;
  String district;
  String fedConstituency;
  String provConstituency;
  String localBody;
  String ward;
  List<dynamic> booth = [];

  UserAsigned({
    // this.name = "",
    // this.sex = "",
    // this.dob = "",
    // this.email = "",
    // this.address = "",
    // this.phone = "",
    this.provision = "",
    this.district = "",
    this.fedConstituency = "",
    this.provConstituency = "",
    this.localBody = "",
    this.ward = "",
    required this.booth,
  });
}

class UserData {
  Map<String, String> listUserData = {};

  String? name;
  String? sex;
  String? dob;
  String? email;
  String? address;
  String? phone;
}
