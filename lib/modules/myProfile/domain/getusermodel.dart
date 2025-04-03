class UserDetails {
  Data data;
  String ApiToken;

  UserDetails({
    required this.data,
    required this.ApiToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    data: Data.fromJson(json["data"] ?? {}),
    ApiToken: json["ApiToken"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "ApiToken": ApiToken,
  };
}

class Data {
  UploadId uploadId;
  BankDetails bankDetails;
  String id;
  String phone;
  String refferalCode;
  String userType;
  dynamic wallet;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  dynamic city;
  dynamic dob;
  dynamic email;
  dynamic fullName;
  dynamic gender;
  dynamic image;
  dynamic state;

  Data({
    required this.uploadId,
    required this.bankDetails,
    required this.id,
    required this.phone,
    required this.refferalCode,
    required this.userType,
    required this.wallet,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.city,
    this.dob,
    this.email,
    this.fullName,
    this.gender,
    this.image,
    this.state,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uploadId: UploadId.fromJson(json["uploadId"] ?? {}),
    bankDetails: BankDetails.fromJson(json["bankDetails"] ?? {}),
    id: json["_id"] ?? '',
    phone: json["phone"] ?? '',
    refferalCode: json["refferalCode"] ?? '',
    userType: json["userType"] ?? '',
    wallet: json["wallet"] ?? 2,
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    v: json["__v"] ?? 0,
    city: json["city"] ?? '',
    dob: json["dob"] ?? '',
    email: json["email"] ?? '',
    fullName: json["fullName"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"],
    state: json["state"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "uploadId": uploadId.toJson(),
    "bankDetails": bankDetails.toJson(),
    "_id": id,
    "phone": phone,
    "refferalCode": refferalCode,
    "userType": userType,
    "wallet": wallet,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "city": city,
    "dob": dob,
    "email": email,
    "fullName": fullName,
    "gender": gender,
    "image": image,
    "state": state,
  };
}

class BankDetails {
  bool isUploadbankDetails;

  BankDetails({
    required this.isUploadbankDetails,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    isUploadbankDetails: json["isUploadbankDetails"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "isUploadbankDetails": isUploadbankDetails,
  };
}

class UploadId {
  bool isAadharCardUpload;
  bool isPanCardUpload;

  UploadId({
    required this.isAadharCardUpload,
    required this.isPanCardUpload,
  });

  factory UploadId.fromJson(Map<String, dynamic> json) => UploadId(
    isAadharCardUpload: json["isAadharCardUpload"] ?? false,
    isPanCardUpload: json["isPanCardUpload"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "isAadharCardUpload": isAadharCardUpload,
    "isPanCardUpload": isPanCardUpload,
  };
}
