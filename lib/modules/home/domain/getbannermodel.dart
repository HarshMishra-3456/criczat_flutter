class GetBanner {
  List<BannerData> banners;

  GetBanner({
    required this.banners,
  });

  factory GetBanner.fromJson(Map<String, dynamic> json) => GetBanner(
    banners: List<BannerData>.from(json["banners"].map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
  };
}

class BannerData {
  String image;

  BannerData({
    required this.image,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}
