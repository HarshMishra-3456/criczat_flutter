class GetPointSystem {
  GetPointSystemData data;

  GetPointSystem({
    required this.data,
  });

  factory GetPointSystem.fromJson(Map<String, dynamic> json) => GetPointSystem(
    data: GetPointSystemData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class GetPointSystemData {
  String id;
  int battingRun;
  int battingFourBonus;
  int battingSixBonus;
  int battingThirtyBonus;
  int battingHalfCenturyBonus;
  int battingCenturyBonus;
  int battingDisMissalForDuck;
  int bowlingWicketExceptRunOut;
  int bowlingMaidenOver;
  int bowlingLbw;
  int threeWicketHaulBonus;
  int fourWicketHaulBonus;
  int fiveWicketHaulBonus;
  int fieldingCatch;
  int fieldingThreeCatch;
  int fieldingStumping;
  int fieldingRunOutDirect;
  int fieldingRunOutMultiplayerInvolved;
  int v;

  GetPointSystemData({
    required this.id,
    required this.battingRun,
    required this.battingFourBonus,
    required this.battingSixBonus,
    required this.battingThirtyBonus,
    required this.battingHalfCenturyBonus,
    required this.battingCenturyBonus,
    required this.battingDisMissalForDuck,
    required this.bowlingWicketExceptRunOut,
    required this.bowlingMaidenOver,
    required this.bowlingLbw,
    required this.threeWicketHaulBonus,
    required this.fourWicketHaulBonus,
    required this.fiveWicketHaulBonus,
    required this.fieldingCatch,
    required this.fieldingThreeCatch,
    required this.fieldingStumping,
    required this.fieldingRunOutDirect,
    required this.fieldingRunOutMultiplayerInvolved,
    required this.v,
  });

  factory GetPointSystemData.fromJson(Map<String, dynamic> json) => GetPointSystemData(
    id: json["_id"],
    battingRun: json["battingRun"],
    battingFourBonus: json["battingFourBonus"],
    battingSixBonus: json["battingSixBonus"],
    battingThirtyBonus: json["battingThirtyBonus"],
    battingHalfCenturyBonus: json["battingHalfCenturyBonus"],
    battingCenturyBonus: json["battingCenturyBonus"],
    battingDisMissalForDuck: json["battingDisMissalForDuck"],
    bowlingWicketExceptRunOut: json["bowlingWicketExceptRunOut"],
    bowlingMaidenOver: json["bowlingMaidenOver"],
    bowlingLbw: json["bowlingLBW"],
    threeWicketHaulBonus: json["threeWicketHaulBonus"],
    fourWicketHaulBonus: json["fourWicketHaulBonus"],
    fiveWicketHaulBonus: json["fiveWicketHaulBonus"],
    fieldingCatch: json["fieldingCatch"],
    fieldingThreeCatch: json["fieldingThreeCatch"],
    fieldingStumping: json["fieldingStumping"],
    fieldingRunOutDirect: json["fieldingRunOutDirect"],
    fieldingRunOutMultiplayerInvolved: json["fieldingRunOutMultiplayerInvolved"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "battingRun": battingRun,
    "battingFourBonus": battingFourBonus,
    "battingSixBonus": battingSixBonus,
    "battingThirtyBonus": battingThirtyBonus,
    "battingHalfCenturyBonus": battingHalfCenturyBonus,
    "battingCenturyBonus": battingCenturyBonus,
    "battingDisMissalForDuck": battingDisMissalForDuck,
    "bowlingWicketExceptRunOut": bowlingWicketExceptRunOut,
    "bowlingMaidenOver": bowlingMaidenOver,
    "bowlingLBW": bowlingLbw,
    "threeWicketHaulBonus": threeWicketHaulBonus,
    "fourWicketHaulBonus": fourWicketHaulBonus,
    "fiveWicketHaulBonus": fiveWicketHaulBonus,
    "fieldingCatch": fieldingCatch,
    "fieldingThreeCatch": fieldingThreeCatch,
    "fieldingStumping": fieldingStumping,
    "fieldingRunOutDirect": fieldingRunOutDirect,
    "fieldingRunOutMultiplayerInvolved": fieldingRunOutMultiplayerInvolved,
    "__v": v,
  };
}
