class FantasyHelp {
  List<FantasyHelpData> data;

  FantasyHelp({
    required this.data,
  });

  factory FantasyHelp.fromJson(Map<String, dynamic> json) => FantasyHelp(
    data: List<FantasyHelpData>.from(json["data"].map((x) => FantasyHelpData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FantasyHelpData {
  String privacy;

  FantasyHelpData({
    required this.privacy,
  });

  factory FantasyHelpData.fromJson(Map<String, dynamic> json) => FantasyHelpData(
    privacy: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "title": privacy,
  };
}
