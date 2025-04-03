class GetJoinedContestByMatchId {
  List<GetJoinedContestData> data;

  GetJoinedContestByMatchId({
    required this.data,
  });

  factory GetJoinedContestByMatchId.fromJson(Map<String, dynamic> json) => GetJoinedContestByMatchId(
    data: List<GetJoinedContestData>.from(json["data"].map((x) => GetJoinedContestData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetJoinedContestData {
  String id;
  int match;
  String name;
  int entryFee;
  int prizePool;
  DateTime startTime;
  DateTime endTime;
  List<Participant> participants;
  String status;
  String type;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int maxParticipants;
  String rules;
  ContestSettings contestSettings;

  GetJoinedContestData({
    required this.id,
    required this.match,
    required this.name,
    required this.entryFee,
    required this.prizePool,
    required this.startTime,
    required this.endTime,
    required this.participants,
    required this.status,
    required this.type,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.maxParticipants,
    required this.rules,
    required this.contestSettings,
  });

  factory GetJoinedContestData.fromJson(Map<String, dynamic> json) => GetJoinedContestData(
    id: json["_id"],
    match: json["match"],
    name: json["name"],
    entryFee: json["entryFee"],
    prizePool: json["prizePool"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
    status: json["status"],
    type: json["type"],
    code: json["code"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    maxParticipants: json["maxParticipants"],
    rules: json["rules"] ?? '',
    contestSettings: json["contestSettings"] != null ? ContestSettings.fromJson(json["contestSettings"]) : ContestSettings(id: '', contestType: '', prizePool: 0, winLevels: [], v: 0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "match": match,
    "name": name,
    "entryFee": entryFee,
    "prizePool": prizePool,
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "status": status,
    "type": type,
    "code": code,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "maxParticipants": maxParticipants,
    "rules": rules,
    "contestSettings": contestSettings.toJson(),
  };
}

class ContestSettings {
  String id;
  String contestType;
  int prizePool;
  List<WinLevel> winLevels;
  int v;

  ContestSettings({
    required this.id,
    required this.contestType,
    required this.prizePool,
    required this.winLevels,
    required this.v,
  });

  factory ContestSettings.fromJson(Map<String, dynamic> json) => ContestSettings(
    id: json["_id"],
    contestType: json["contestType"],
    prizePool: json["prizePool"],
    winLevels: List<WinLevel>.from(json["winLevels"].map((x) => WinLevel.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "contestType": contestType,
    "prizePool": prizePool,
    "winLevels": List<dynamic>.from(winLevels.map((x) => x.toJson())),
    "__v": v,
  };
}

class WinLevel {
  int position;
  int percentage;
  String id;

  WinLevel({
    required this.position,
    required this.percentage,
    required this.id,
  });

  factory WinLevel.fromJson(Map<String, dynamic> json) => WinLevel(
    position: json["position"],
    percentage: json["percentage"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "percentage": percentage,
    "_id": id,
  };
}

class Participant {
  User user;
  String id;

  Participant({
    required this.user,
    required this.id,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    user: User.fromJson(json["user"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "_id": id,
  };
}

class User {
  String id;
  String phone;
  dynamic fullName;
  String gender;
  String image;
  String state;

  User({
    required this.id,
    required this.phone,
    required this.fullName,
    required this.gender,
    required this.image,
    required this.state,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    phone: json["phone"] ?? '',
    fullName: json["fullName"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"] ?? '',
    state: json["state"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "fullName": fullName,
    "gender": gender,
    "image": image,
    "state": state,
  };
}
