class FantasyFaq {
  List<FantasyFaqData> data;

  FantasyFaq({
    required this.data,
  });

  factory FantasyFaq.fromJson(Map<String, dynamic> json) => FantasyFaq(
    data: List<FantasyFaqData>.from(json["data"].map((x) => FantasyFaqData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FantasyFaqData {
  String question;
  String answer;
  DateTime createdAt;

  FantasyFaqData({
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory FantasyFaqData.fromJson(Map<String, dynamic> json) => FantasyFaqData(
    question: json["question"] ?? '',
    answer: json["answer"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "createdAt": createdAt.toIso8601String(),
  };
}
