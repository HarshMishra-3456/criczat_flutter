class FantasyLegality {
  List<FantasyLegalityData> data;

  FantasyLegality({
    required this.data,
  });

  factory FantasyLegality.fromJson(Map<String, dynamic> json) => FantasyLegality(
    data: List<FantasyLegalityData>.from(json["data"].map((x) => FantasyLegalityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FantasyLegalityData {
  String privacy;

  FantasyLegalityData({
    required this.privacy,
  });

  factory FantasyLegalityData.fromJson(Map<String, dynamic> json) => FantasyLegalityData(
    privacy: json["legality"],
  );

  Map<String, dynamic> toJson() => {
    "legality": privacy,
  };
}
