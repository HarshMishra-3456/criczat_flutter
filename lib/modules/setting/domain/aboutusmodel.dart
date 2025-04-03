class AboutUs {
  List<AboutUsData> data;

  AboutUs({
    required this.data,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
    data: List<AboutUsData>.from(json["data"].map((x) => AboutUsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AboutUsData {
  String aboutUs;

  AboutUsData({
    required this.aboutUs,
  });

  factory AboutUsData.fromJson(Map<String, dynamic> json) => AboutUsData(
    aboutUs: json["aboutUs"],
  );

  Map<String, dynamic> toJson() => {
    "aboutUs": aboutUs,
  };
}
