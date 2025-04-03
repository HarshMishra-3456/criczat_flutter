class GetOffersandProgram {
  List<GetOffersandProgramData> data;

  GetOffersandProgram({
    required this.data,
  });

  factory GetOffersandProgram.fromJson(Map<String, dynamic> json) => GetOffersandProgram(
    data: List<GetOffersandProgramData>.from(json["data"].map((x) => GetOffersandProgramData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetOffersandProgramData {
  String id;
  String name;
  String image;

  GetOffersandProgramData({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GetOffersandProgramData.fromJson(Map<String, dynamic> json) => GetOffersandProgramData(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
  };
}
