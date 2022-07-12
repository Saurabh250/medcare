class ReviewModel {
  final String reviewExpertUID;
  final dynamic reviewRatingValue;
  final String reviewText;
  final String reviewSessionUID;
  final String reviewUserUID;
  final String reviewUserName;
  final bool reviewPresent;

  ReviewModel({
    required this.reviewExpertUID,
    required this.reviewRatingValue,
    required this.reviewText,
    required this.reviewSessionUID,
    required this.reviewUserUID,
    required this.reviewUserName,
    required this.reviewPresent,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewExpertUID: json['doctorID'],
      reviewRatingValue: json['rating'],
      reviewPresent: json['reviewPresent'],
      reviewSessionUID: json['sessionID'],
      reviewText: json['review'],
      reviewUserUID: json['userID'],
      reviewUserName: json['userName'],
    );
  }
}
