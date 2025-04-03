class GetFantasyPlayerPoint {
  Response response;

  GetFantasyPlayerPoint({
    required this.response,
  });

  factory GetFantasyPlayerPoint.fromJson(Map<String, dynamic> json) => GetFantasyPlayerPoint(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  int matchId;
  Points points;

  Response({
    required this.matchId,
    required this.points,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    matchId: json["match_id"],
    points: Points.fromJson(json["points"]),
  );

  Map<String, dynamic> toJson() => {
    "match_id": matchId,
    "points": points.toJson(),
  };
}

class Points {
  Team teama;
  Team teamb;

  Points({
    required this.teama,
    required this.teamb,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    teama: Team.fromJson(json["teama"]),
    teamb: Team.fromJson(json["teamb"]),
  );

  Map<String, dynamic> toJson() => {
    "teama": teama.toJson(),
    "teamb": teamb.toJson(),
  };
}

class Team {
  List<Playing11> playing11;

  Team({
    required this.playing11,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    playing11: List<Playing11>.from(json["playing11"].map((x) => Playing11.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "playing11": List<dynamic>.from(playing11.map((x) => x.toJson())),
  };
}

class Playing11 {
  String pid;
  String name;
  String role;
  String rating;
  String point;

  Playing11({
    required this.pid,
    required this.name,
    required this.role,
    required this.rating,
    required this.point,
  });

  factory Playing11.fromJson(Map<String, dynamic> json) => Playing11(
    pid: json["pid"],
    name: json["name"] ?? '',
    role: json["role"],
    rating: json["rating"],
    point: json["point"],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "name": name,
    "role": role,
    "rating": rating,
    "point": point,
  };
}
