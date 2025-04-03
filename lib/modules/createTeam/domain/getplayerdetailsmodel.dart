class GetPlayerDetailsModel {
  GetPlayerDetails response;

  GetPlayerDetailsModel({
    required this.response,
  });

  factory GetPlayerDetailsModel.fromJson(Map<String, dynamic> json) => GetPlayerDetailsModel(
    response: GetPlayerDetails.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class GetPlayerDetails {
  List<GetPlayerDetailsData> squads;

  GetPlayerDetails({
    required this.squads,
  });

  factory GetPlayerDetails.fromJson(Map<String, dynamic> json) => GetPlayerDetails(
    squads: List<GetPlayerDetailsData>.from(json["squads"].map((x) => GetPlayerDetailsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "squads": List<dynamic>.from(squads.map((x) => x.toJson())),
  };
}

class GetPlayerDetailsData {
  String teamId;
  String title;
  Team team;
  List<Player> players;
  List<LastMatchPlayed> lastMatchPlayed;

  GetPlayerDetailsData({
    required this.teamId,
    required this.title,
    required this.team,
    required this.players,
    required this.lastMatchPlayed,
  });

  factory GetPlayerDetailsData.fromJson(Map<String, dynamic> json) {
    Team team = Team.fromJson(json["team"]);

    List<Player> players = List<Player>.from(json["players"].map((x) {
      Player player = Player.fromJson(x);
      player.teamAbbr = team.abbr;
      return player;
    }));

    return GetPlayerDetailsData(
      teamId: json["team_id"],
      title: json["title"],
      team: team,
      players: players,
      lastMatchPlayed: List<LastMatchPlayed>.from(json["last_match_played"].map((x) => LastMatchPlayed.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
    "title": title,
    "team": team.toJson(),
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
    "last_match_played": List<dynamic>.from(lastMatchPlayed.map((x) => x.toJson())),
  };
}

class LastMatchPlayed {
  String playerId;
  String title;

  LastMatchPlayed({
    required this.playerId,
    required this.title,
  });

  factory LastMatchPlayed.fromJson(Map<String, dynamic> json) => LastMatchPlayed(
    playerId: json["player_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "player_id": playerId,
    "title": title,
  };
}

class Player {
  int pid;
  String title;
  String shortName;
  String firstName;
  String lastName;
  String middleName;
  dynamic birthdate;
  String birthplace;
  String country;
  // List<dynamic> primaryTeam;
  String logoUrl;
  String playingRole;
  String battingStyle;
  String bowlingStyle;
  String fieldingPosition;
  int recentMatch;
  int recentAppearance;
  double fantasyPlayerRating;
  dynamic altName;
  String facebookProfile;
  String twitterProfile;
  String instagramProfile;
  String debutData;
  String thumbUrl;
  String teamAbbr;
  dynamic nationality;
  String fantasyTotalPoints;

  Player({
    required this.pid,
    required this.title,
    required this.shortName,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.birthdate,
    required this.birthplace,
    required this.country,
    // required this.primaryTeam,
    required this.logoUrl,
    required this.playingRole,
    required this.battingStyle,
    required this.bowlingStyle,
    required this.fieldingPosition,
    required this.recentMatch,
    required this.recentAppearance,
    required this.fantasyPlayerRating,
    required this.altName,
    required this.facebookProfile,
    required this.twitterProfile,
    required this.instagramProfile,
    required this.debutData,
    required this.thumbUrl,
    required this.teamAbbr,
    required this.nationality,
    required this.fantasyTotalPoints,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    pid: json["pid"],
    title: json["title"],
    shortName: json["short_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    middleName: json["middle_name"],
    birthdate: json["birthdate"],
    birthplace: json["birthplace"],
    country: json["country"],
    // primaryTeam: List<dynamic>.from(json["primary_team"].map((x) => x)),
    logoUrl: json["logo_url"],
    playingRole: json["playing_role"],
    battingStyle: json["batting_style"],
    bowlingStyle: json["bowling_style"],
    fieldingPosition: json["fielding_position"],
    recentMatch: json["recent_match"],
    recentAppearance: json["recent_appearance"],
    fantasyPlayerRating: json["fantasy_player_rating"].toDouble(),
    altName: json["alt_name"],
    facebookProfile: json["facebook_profile"],
    twitterProfile: json["twitter_profile"],
    instagramProfile: json["instagram_profile"],
    debutData: json["debut_data"],
    thumbUrl: json["thumb_url"],
    teamAbbr: '',
    nationality: json["nationality"],
    fantasyTotalPoints: json["fantasy_total_points"],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "title": title,
    "short_name": shortName,
    "first_name": firstName,
    "last_name": lastName,
    "middle_name": middleName,
    // "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "birthplace": birthplace,
    "country": country,
    "team_abbr": teamAbbr,
    "logo_url": logoUrl,
    "playing_role": playingRole,
    "batting_style": battingStyle,
    "bowling_style": bowlingStyle,
    "fielding_position": fieldingPosition,
    "recent_match": recentMatch,
    "recent_appearance": recentAppearance,
    "fantasy_player_rating": fantasyPlayerRating,
    "alt_name": altName,
    "facebook_profile": facebookProfile,
    "twitter_profile": twitterProfile,
    "instagram_profile": instagramProfile,
    "debut_data": debutData,
    "thumb_url": thumbUrl,
    // "nationality": nationality,
    "fantasy_total_points": fantasyTotalPoints,
  };
}

class Team {
  int tid;
  String title;
  String abbr;
  String altName;
  String type;
  String thumbUrl;
  String logoUrl;
  String country;
  String sex;

  Team({
    required this.tid,
    required this.title,
    required this.abbr,
    required this.altName,
    required this.type,
    required this.thumbUrl,
    required this.logoUrl,
    required this.country,
    required this.sex,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    tid: json["tid"],
    title: json["title"],
    abbr: json["abbr"],
    altName: json["alt_name"],
    type: json["type"],
    thumbUrl: json["thumb_url"],
    logoUrl: json["logo_url"],
    country: json["country"],
    sex: json["sex"],
  );

  Map<String, dynamic> toJson() => {
    "tid": tid,
    "title": title,
    "abbr": abbr,
    "alt_name": altName,
    "type": type,
    "thumb_url": thumbUrl,
    "logo_url": logoUrl,
    "country": country,
    "sex": sex,
  };
}
