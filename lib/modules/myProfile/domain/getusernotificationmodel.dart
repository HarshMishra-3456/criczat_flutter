class GetUserNotification {
  List<GetUserNotificationData> data;

  GetUserNotification({
    required this.data,
  });

  factory GetUserNotification.fromJson(Map<String, dynamic> json) => GetUserNotification(
    data: List<GetUserNotificationData>.from(json["data"].map((x) => GetUserNotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetUserNotificationData {
  String id;
  String title;
  dynamic body;
  // String date;
  DateTime createdAt;
  dynamic updatedAt;
  int v;

  GetUserNotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetUserNotificationData.fromJson(Map<String, dynamic> json) => GetUserNotificationData(
    id: json["_id"],
    title: json["title"],
    body: json["content"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "body": body,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
