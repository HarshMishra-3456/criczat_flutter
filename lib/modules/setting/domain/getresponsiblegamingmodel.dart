class ResponsibleGaming {
  List<ResponsibleGamingData> data;

  ResponsibleGaming({
    required this.data,
  });

  factory ResponsibleGaming.fromJson(Map<String, dynamic> json) => ResponsibleGaming(
    data: List<ResponsibleGamingData>.from(json["data"].map((x) => ResponsibleGamingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ResponsibleGamingData {
  String privacy;

  ResponsibleGamingData({
    required this.privacy,
  });

  factory ResponsibleGamingData.fromJson(Map<String, dynamic> json) => ResponsibleGamingData(
    privacy: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "title": privacy,
  };
}
