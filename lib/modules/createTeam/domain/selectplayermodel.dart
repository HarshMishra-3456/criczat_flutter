class SelectPlayer {
  final int pid;
  final String shortName;
  final String teamname;
  final String fantasyPlayerRating;
  final String fantasyPlayerPoint;
  final String playingRole;

  SelectPlayer({
    required this.pid,
    required this.shortName,
    required this.teamname,
    required this.fantasyPlayerPoint,
    required this.fantasyPlayerRating,
    required this.playingRole,
  });

  factory SelectPlayer.fromJson(Map<String, dynamic> json) {
    return SelectPlayer(
      pid: json['pid'],
      shortName: json['short_name'],
      teamname: json['team_name'],
      fantasyPlayerRating: json['fantasy_player_rating'],
      playingRole: json['playing_role'], fantasyPlayerPoint: json['fantasy_player_point'],
    );
  }
}
