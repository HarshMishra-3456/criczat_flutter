class TermsandConditions {
  List<TermsandConditionsData> data;

  TermsandConditions({
    required this.data,
  });

  factory TermsandConditions.fromJson(Map<String, dynamic> json) => TermsandConditions(
    data: List<TermsandConditionsData>.from(json["data"].map((x) => TermsandConditionsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TermsandConditionsData {
  String privacy;

  TermsandConditionsData({
    required this.privacy,
  });

  factory TermsandConditionsData.fromJson(Map<String, dynamic> json) => TermsandConditionsData(
    privacy: json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "terms": privacy,
  };
}
