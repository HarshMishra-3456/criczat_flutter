class PrivacyPolicy {
  List<PrivacyPolicyData> data;

  PrivacyPolicy({
    required this.data,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
    data: List<PrivacyPolicyData>.from(json["data"].map((x) => PrivacyPolicyData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PrivacyPolicyData {
  String privacy;

  PrivacyPolicyData({
    required this.privacy,
  });

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) => PrivacyPolicyData(
    privacy: json["privacy"],
  );

  Map<String, dynamic> toJson() => {
    "privacy": privacy,
  };
}
