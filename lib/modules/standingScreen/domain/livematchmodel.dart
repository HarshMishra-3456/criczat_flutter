class GetLiveMatches {
  List<GetLiveMatchesData> data;

  GetLiveMatches({
    required this.data,
  });

  factory GetLiveMatches.fromJson(Map<String, dynamic> json) => GetLiveMatches(
    data: json["data"] == null
        ? []
        : List<GetLiveMatchesData>.from(json["data"].map((x) => GetLiveMatchesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetLiveMatchesData {
  String id;
  MatchId matchId;
  int match;
  String name;
  int entryFee;
  int prizePool;
  DateTime startTime;
  DateTime endTime;
  int maxParticipants;
  String status;
  String type;
  String code;
  bool adminStatus;
  List<Participants> participants;
  List<dynamic> winners;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  ContestSettings contestSettings;

  GetLiveMatchesData({
    required this.id,
    required this.matchId,
    required this.match,
    required this.name,
    required this.entryFee,
    required this.prizePool,
    required this.startTime,
    required this.endTime,
    required this.maxParticipants,
    required this.status,
    required this.type,
    required this.code,
    required this.adminStatus,
    required this.participants,
    required this.winners,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.contestSettings,
  });

  factory GetLiveMatchesData.fromJson(Map<String, dynamic> json) => GetLiveMatchesData(
    id: json["_id"] ?? '',
    matchId: MatchId.fromJson(json["matchId"] ?? {}),
    match: json["match"] ?? 0,
    name: json["name"] ?? '',
    entryFee: json["entryFee"] ?? 0,
    prizePool: json["prizePool"] ?? 0,
    startTime: DateTime.parse(json["startTime"] ?? DateTime.now().toIso8601String()),
    endTime: DateTime.parse(json["endTime"] ?? DateTime.now().toIso8601String()),
    maxParticipants: json["maxParticipants"] ?? 0,
    status: json["status"] ?? '',
    type: json["type"] ?? '',
    code: json["code"] ?? '',
    adminStatus: json["adminStatus"] ?? false,
    participants: json["participants"] == null
        ? []
        : List<Participants>.from(json["participants"].map((x) => Participants.fromJson(x))),
    winners: json["winners"] == null ? [] : List<dynamic>.from(json["winners"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    v: json["__v"] ?? 0,
    contestSettings: json["contestSettings"] != null ? ContestSettings.fromJson(json["contestSettings"]) : ContestSettings(id: '', contestType: '', prizePool: 0, winLevels: [], v: 0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "matchId": matchId.toJson(),
    "match": match,
    "name": name,
    "entryFee": entryFee,
    "prizePool": prizePool,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "maxParticipants": maxParticipants,
    "status": status,
    "type": type,
    "code": code,
    "adminStatus": adminStatus,
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "winners": List<dynamic>.from(winners.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "contestSettings": contestSettings.toJson(),
  };
}

class MatchId {
  TeamaClass teama;
  TeamaClass teamb;
  Venue venue;
  String id;
  int matchId;
  String title;
  String shortTitle;
  String subtitle;
  String matchNumber;
  int format;
  String formatStr;
  String status;
  String statusStr;
  String statusNote;
  bool verified;
  bool preSquad;
  bool oddsAvailable;
  int gameState;
  String gameStateStr;
  bool domestic;
  Competition competition;

  MatchId({
    required this.teama,
    required this.teamb,
    required this.venue,
    required this.id,
    required this.matchId,
    required this.title,
    required this.shortTitle,
    required this.subtitle,
    required this.matchNumber,
    required this.format,
    required this.formatStr,
    required this.status,
    required this.statusStr,
    required this.statusNote,
    required this.verified,
    required this.preSquad,
    required this.oddsAvailable,
    required this.gameState,
    required this.gameStateStr,
    required this.domestic,
    required this.competition,
  });

  factory MatchId.fromJson(Map<String, dynamic> json) => MatchId(
    teama: TeamaClass.fromJson(json["teama"] ?? {}),
    teamb: TeamaClass.fromJson(json["teamb"] ?? {}),
    venue: Venue.fromJson(json["venue"] ?? {}),
    id: json["_id"] ?? '',
    matchId: json["match_id"] ?? 0,
    title: json["title"] ?? '',
    shortTitle: json["short_title"] ?? '',
    subtitle: json["subtitle"] ?? '',
    matchNumber: json["match_number"] ?? '',
    format: json["format"] ?? 0,
    formatStr: json["format_str"] ?? '',
    status: json["status"] ?? '',
    statusStr: json["status_str"] ?? '',
    statusNote: json["status_note"] ?? '',
    verified: json["verified"] ?? false,
    preSquad: json["pre_squad"] ?? false,
    oddsAvailable: json["odds_available"] ?? false,
    gameState: json["game_state"] ?? 0,
    gameStateStr: json["game_state_str"] ?? '',
    domestic: json["domestic"] ?? false,
    competition: Competition.fromJson(json["competition"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "teama": teama.toJson(),
    "teamb": teamb.toJson(),
    "venue": venue.toJson(),
    "_id": id,
    "match_id": matchId,
    "title": title,
    "short_title": shortTitle,
    "subtitle": subtitle,
    "match_number": matchNumber,
    "format": format,
    "format_str": formatStr,
    "status": status,
    "status_str": statusStr,
    "status_note": statusNote,
    "verified": verified,
    "pre_squad": preSquad,
    "odds_available": oddsAvailable,
    "game_state": gameState,
    "game_state_str": gameStateStr,
    "domestic": domestic,
    "competition": competition.toJson(),
  };
}

class Venue {
  String venueId;
  String name;
  String location;
  String country;
  String timezone;

  Venue({
    required this.venueId,
    required this.name,
    required this.location,
    required this.country,
    required this.timezone,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    venueId: json["venue_id"] ?? '',
    name: json["name"] ?? '',
    location: json["location"] ?? '',
    country: json["country"] ?? '',
    timezone: json["timezone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "venue_id": venueId,
    "name": name,
    "location": location,
    "country": country,
    "timezone": timezone,
  };
}

class Competition {
  int cid;
  String title;
  String abbr;

  Competition({
    required this.cid,
    required this.title,
    required this.abbr,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    cid: json["cid"] ?? 0,
    title: json["title"] ?? '',
    abbr: json["abbr"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "title": title,
    "abbr": abbr,
  };
}

class TeamaClass {
  int teamId;
  String name;
  String shortName;
  String logoUrl;
  String thumbUrl;

  TeamaClass({
    required this.teamId,
    required this.name,
    required this.shortName,
    required this.logoUrl,
    required this.thumbUrl,
  });

  factory TeamaClass.fromJson(Map<String, dynamic> json) => TeamaClass(
    teamId: json["team_id"] ?? 0,
    name: json["name"] ?? '',
    shortName: json["short_name"] ?? '',
    logoUrl: json["logo_url"] ?? '',
    thumbUrl: json["thumb_url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "name": name,
    "short_name": shortName,
    "logo_url": logoUrl,
    "thumb_url": thumbUrl,
  };
}

class Participants {
  User user;
  TeamClass team;
  String id;

  Participants({
    required this.user,
    required this.team,
    required this.id,
  });

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
    user: User.fromJson(json["user"] ?? {}),
    team: TeamClass.fromJson(json["team"] ?? {}),
    id: json["_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "team": team.toJson(),
    "_id": id,
  };
}

class TeamClass {
  String id;
  String name;
  // String contest;
  int match;
  String createdBy;
  int captain;
  dynamic viceCaptain;
  dynamic totalCredit;
  dynamic totalWinningPoint;
  double remaningCredit;
  List<PlayersPoint> playersPoints;
  bool isDistribution;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  TeamClass({
    required this.id,
    required this.name,
    // required this.contest,
    required this.playersPoints,
    required this.viceCaptain,
    required this.captain,
    required this.match,
    required this.createdBy,
    required this.totalCredit,
    required this.totalWinningPoint,
    required this.remaningCredit,
    required this.isDistribution,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TeamClass.fromJson(Map<String, dynamic> json) => TeamClass(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    // contest: json["contest"] ?? '',
    match: json["match"] ?? 0,
    viceCaptain: json["viceCaptain"] ?? '',
    captain: json["captain"] ?? '',
    createdBy: json["createdBy"] ?? '',
    totalCredit: json["totalCredit"] ?? 0,
    totalWinningPoint: json["totalWinningPoint"] ?? 0,
    remaningCredit: json["remaningCredit"]?.toDouble() ?? 0.0,
    isDistribution: json["isDistribution"] ?? false,
    playersPoints: json["playersPoints"] == null
        ? []
        : List<PlayersPoint>.from(json["playersPoints"].map((x) => PlayersPoint.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    // "contest": contest,
    "match": match,
    "captain": captain,
    "viceCaptain": viceCaptain,
    "createdBy": createdBy,
    "totalCredit": totalCredit,
    "totalWinningPoint": totalWinningPoint,
    "remaningCredit": remaningCredit,
    "isDistribution": isDistribution,
    "playersPoints": List<dynamic>.from(playersPoints.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class PlayersPoint {
  dynamic name;
  int players;
  dynamic points;

  PlayersPoint({
    required this.name,
    required this.players,
    required this.points,
  });

  factory PlayersPoint.fromJson(Map<String, dynamic> json) => PlayersPoint(
    name: json["name"] ?? '',
    players: json["players"] ?? 0,
    points: json["points"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "players": players,
    "points": points,
  };
}

class ContestSettings {
  String id;
  String contestType;
  int prizePool;
  List<WinLevels> winLevels;
  int v;

  ContestSettings({
    required this.id,
    required this.contestType,
    required this.prizePool,
    required this.winLevels,
    required this.v,
  });

  factory ContestSettings.fromJson(Map<String, dynamic> json) => ContestSettings(
    id: json["_id"] ?? '',
    contestType: json["contestType"] ?? '',
    prizePool: json["prizePool"] ?? 0,
    winLevels: json["winLevels"] == null
        ? []
        : List<WinLevels>.from(json["winLevels"].map((x) => WinLevels.fromJson(x))),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "contestType": contestType,
    "prizePool": prizePool,
    "winLevels": List<dynamic>.from(winLevels.map((x) => x.toJson())),
    "__v": v,
  };
}

class WinLevels {
  int position;
  int percentage;
  String id;

  WinLevels({
    required this.position,
    required this.percentage,
    required this.id,
  });

  factory WinLevels.fromJson(Map<String, dynamic> json) => WinLevels(
    position: json["position"] ?? 0,
    percentage: json["percentage"] ?? 0,
    id: json["_id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "percentage": percentage,
    "_id": id,
  };
}

class User {
  String id;
  String phone;
  String email;
  String fullName;
  String gender;
  String image;
  String state;

  User({
    required this.id,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.image,
    required this.state,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? '',
    phone: json["phone"] ?? '',
    email: json["email"] ?? '',
    fullName: json["fullName"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    state: json["state"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "email": email,
    "fullName": fullName,
    "gender": gender,
    "image": image,
    "state": state,
  };
}
