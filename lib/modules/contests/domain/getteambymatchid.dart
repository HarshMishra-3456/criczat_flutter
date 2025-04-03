class GetTeamByMatchId {
  List<GetTeamByMatchIdData> data;

  GetTeamByMatchId({
    required this.data,
  });

  factory GetTeamByMatchId.fromJson(Map<String, dynamic> json) => GetTeamByMatchId(
    data: List<GetTeamByMatchIdData>.from(json["data"].map((x) => GetTeamByMatchIdData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetTeamByMatchIdData {
  String id;
  String name;
  int match;
  List<PlayersDatum> playersData;
  int captain;
  int viceCaptain;
  // String createdBy;
  int totalCredit;
  int totalWinningPoint;
  double remaningCredit;
  // bool isDistribution;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetTeamByMatchIdData({
    required this.id,
    required this.name,
    required this.match,
    required this.playersData,
    required this.captain,
    required this.viceCaptain,
    // required this.createdBy,
    required this.totalCredit,
    required this.totalWinningPoint,
    required this.remaningCredit,
    // required this.isDistribution,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetTeamByMatchIdData.fromJson(Map<String, dynamic> json) => GetTeamByMatchIdData(
    id: json["_id"],
    name: json["name"],
    match: json["match"],
    playersData: List<PlayersDatum>.from(json["playersData"].map((x) => PlayersDatum.fromJson(x))),
    captain: json["captain"],
    viceCaptain: json["viceCaptain"],
    // createdBy: json["createdBy"],
    totalCredit: json["totalCredit"],
    totalWinningPoint: json["totalWinningPoint"],
    remaningCredit: json["remaningCredit"].toDouble(),
    // isDistribution: json["isDistribution"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "match": match,
    "playersData": List<dynamic>.from(playersData.map((x) => x.toJson())),
    "captain": captain,
    "viceCaptain": viceCaptain,
    // "createdBy": createdBy,
    "totalCredit": totalCredit,
    "totalWinningPoint": totalWinningPoint,
    "remaningCredit": remaningCredit,
    // "isDistribution": isDistribution,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class PlayersDatum {
  int players;
  dynamic name;
  double rating;
  String playingRole;
  dynamic team;
  String id;

  PlayersDatum({
    required this.players,
    required this.name,
    required this.rating,
    required this.playingRole,
    required this.team,
    required this.id,
  });

  factory PlayersDatum.fromJson(Map<String, dynamic> json) => PlayersDatum(
    players: json["players"],
    name: json["name"],
    rating: json["rating"].toDouble(),
    playingRole: json["playingRole"],
    team: json["team"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "players": players,
    "name": name,
    "rating": rating,
    "playingRole": playingRole,
    "team": team,
    "_id": id,
  };
}
