//Therapist Model Values

class ExpertModel {
  final String expertName;
  final String expertBio;
  final String expertCity;
  final int expertAge;
  final String expertUID;
  final String expertGender;
  final String expertImgUrl;
  final String expertReferredAs;
  final dynamic expertRating;
  final List expertLanguages;
  final List expertQualifications;
  final List expertTherapyTypes;
  final dynamic expertExperience;
  final Map<dynamic, dynamic> expertTherapyPrices;
  final Map<dynamic, dynamic> expertTherapyStrikedPrices;

  ExpertModel({
    required this.expertName,
    required this.expertBio,
    required this.expertCity,
    required this.expertAge,
    required this.expertUID,
    required this.expertGender,
    required this.expertImgUrl,
    required this.expertReferredAs,
    required this.expertRating,
    required this.expertExperience,
    required this.expertLanguages,
    required this.expertQualifications,
    required this.expertTherapyTypes,
    required this.expertTherapyPrices,
    required this.expertTherapyStrikedPrices,
  });

  factory ExpertModel.fromJson(Map<String, dynamic> json) {
    return ExpertModel(
      expertName: json['name'],
      expertBio: json['bio'],
      expertCity: json['city'],
      expertAge: json['age'],
      expertUID: json['doctorID'],
      expertGender: json['gender'],
      expertImgUrl: json['imgUrl'],
      expertReferredAs: json['referredAs'],
      expertRating: json['rating'],
      expertExperience: json['experience'],
      expertLanguages: json['languages'],
      expertQualifications: json['qualifications'],
      expertTherapyTypes: json['therapyList'],
      expertTherapyPrices: json['therapyPrice'],
      expertTherapyStrikedPrices: json['strikedPrice'],
    );
  }
}
