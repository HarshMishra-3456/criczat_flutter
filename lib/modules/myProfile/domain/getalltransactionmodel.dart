class GetUserAllTransaction {
  List<GetUserAllTransactionData> data;

  GetUserAllTransaction({
    required this.data,
  });

  factory GetUserAllTransaction.fromJson(Map<String, dynamic> json) => GetUserAllTransaction(
    data: List<GetUserAllTransactionData>.from(json["data"].map((x) => GetUserAllTransactionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetUserAllTransactionData {
  String id;
  DateTime date;
  dynamic amount;
  String type;
  int v;

  GetUserAllTransactionData({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.v,
  });

  factory GetUserAllTransactionData.fromJson(Map<String, dynamic> json) => GetUserAllTransactionData(
    id: json["_id"],
    date: DateTime.parse(json["date"]),
    amount: json["amount"],
    type: json["type"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date.toIso8601String(),
    "amount": amount,
    "type": type,
    "__v": v,
  };
}
