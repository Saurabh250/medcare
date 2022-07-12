// AdBanner Model for url

class AdBannerModel {
  final String imgUrl;
  final String bannerLink;

  AdBannerModel({required this.imgUrl, required this.bannerLink});

  factory AdBannerModel.fromJson(Map<String, dynamic> json) {
    return AdBannerModel(
      imgUrl: json['imgUrl'],
      bannerLink: json['bannerLink'],
    );
  }
}
