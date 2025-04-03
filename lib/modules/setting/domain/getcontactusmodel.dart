class Contactus {
  List<ContactusData> data;

  Contactus({
    required this.data,
  });

  factory Contactus.fromJson(Map<String, dynamic> json) => Contactus(
    data: List<ContactusData>.from(json["data"].map((x) => ContactusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ContactusData {
  String id;
  String mobileNumber;
  String email;
  int v;

  ContactusData({
    required this.id,
    required this.mobileNumber,
    required this.email,
    required this.v,
  });

  factory ContactusData.fromJson(Map<String, dynamic> json) => ContactusData(
    id: json["_id"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mobileNumber": mobileNumber,
    "email": email,
    "__v": v,
  };
}
