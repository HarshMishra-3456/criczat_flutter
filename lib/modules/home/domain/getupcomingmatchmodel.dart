class GetUpcomingMatch {
  GetUpcomingMatchData matchIdInfo;

  GetUpcomingMatch({
    required this.matchIdInfo,
  });

  factory GetUpcomingMatch.fromJson(Map<String, dynamic> json) => GetUpcomingMatch(
    matchIdInfo: GetUpcomingMatchData.fromJson(json["matchIdInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "matchIdInfo": matchIdInfo.toJson(),
  };
}

class GetUpcomingMatchData {
  List<UpcomingItem> items;

  GetUpcomingMatchData({
    required this.items,
  });

  factory GetUpcomingMatchData.fromJson(Map<String, dynamic> json) => GetUpcomingMatchData(
    items: List<UpcomingItem>.from(json["items"].map((x) => UpcomingItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class UpcomingItem {
  int matchId;
  String title;
  String shortTitle;
  int status;
  Competition competition;
  Team teama;
  Team teamb;
  DateTime dateStartIst;
  DateTime dateEndIst;
  int highestPrizePool;
  FantasySquads fantasySquads;


  UpcomingItem({
    required this.matchId,
    required this.title,
    required this.shortTitle,
    required this.status,
    required this.competition,
    required this.teama,
    required this.teamb,
    required this.dateStartIst,
    required this.dateEndIst,
    required this.highestPrizePool,
    required this.fantasySquads,
  });

  factory UpcomingItem.fromJson(Map<String, dynamic> json) => UpcomingItem(
    matchId: json["match_id"],
    title: json["title"],
    shortTitle: json["short_title"],
    status: json["status"],
    competition: Competition.fromJson(json["competition"]),
    teama: Team.fromJson(json["teama"]),
    teamb: Team.fromJson(json["teamb"]),
    dateStartIst: DateTime.parse(json["date_start_ist"]),
    dateEndIst: DateTime.parse(json["date_end_ist"]),
    highestPrizePool: json["highestPrizePool"],
    fantasySquads: FantasySquads.fromJson(json["fantasySquads"]),
  );

  Map<String, dynamic> toJson() => {
    "match_id": matchId,
    "title": title,
    "short_title": shortTitle,
    "status": status,
    "competition": competition.toJson(),
    "teama": teama.toJson(),
    "teamb": teamb.toJson(),
    "date_start_ist": dateStartIst.toIso8601String(),
    "date_end_ist": dateEndIst.toIso8601String(),
    "highestPrizePool": highestPrizePool,
    "fantasySquads": fantasySquads.toJson(),
  };
}


class FantasySquads {
  List<TeamaElement> teama;
  List<TeamaElement> teamb;

  FantasySquads({
    required this.teama,
    required this.teamb,
  });

  factory FantasySquads.fromJson(Map<String, dynamic> json) => FantasySquads(
    teama: List<TeamaElement>.from(json["teama"].map((x) => TeamaElement.fromJson(x))),
    teamb: List<TeamaElement>.from(json["teamb"].map((x) => TeamaElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "teama": List<dynamic>.from(teama.map((x) => x.toJson())),
    "teamb": List<dynamic>.from(teamb.map((x) => x.toJson())),
  };
}

class TeamaElement {
  String playerId;
  String substitute;
  String role;
  String playing11;
  String name;

  TeamaElement({
    required this.playerId,
    required this.substitute,
    required this.role,
    required this.playing11,
    required this.name,
  });

  factory TeamaElement.fromJson(Map<String, dynamic> json) => TeamaElement(
    playerId: json["player_id"],
    substitute: json["substitute"],
    role: json["role"],
    playing11: json["playing11"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "player_id": playerId,
    "substitute": substitute,
    "role": role,
    "playing11": playing11,
    "name": name,
  };
}

class Competition {
  int cid;
  String title;
  String abbr;
  String type;
  String category;

  Competition({
    required this.cid,
    required this.title,
    required this.abbr,
    required this.type,
    required this.category,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    cid: json["cid"],
    title: json["title"],
    abbr: json["abbr"],
    type: json["type"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "title": title,
    "abbr": abbr,
    "type": type,
    "category": category,
  };
}

class Team {
  int teamId;
  String name;
  String shortName;
  String logoUrl;

  Team({
    required this.teamId,
    required this.name,
    required this.shortName,
    required this.logoUrl,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamId: json["team_id"],
    name: json["name"],
    shortName: json["short_name"],
    logoUrl: json["logo_url"],
  );

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "name": name,
    "short_name": shortName,
    "logo_url": logoUrl,
  };
}
