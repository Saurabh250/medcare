class SessionModel {
  final dynamic sessionAmountPaid;
  final String sessionExpertUID;
  final String sessionExpertImageURL;
  final String sessionExpertName;
  final bool sessionReviewSubmitted;
  final String sessionTime;
  final String sessionTherapyType;
  final String sessionUserUID;
  final String sessionUserImageURL;
  final String sessionUserName;
  final String sessionUserGender;
  final String sessionUID;

  SessionModel({
    this.sessionAmountPaid,
    required this.sessionExpertUID,
    required this.sessionExpertImageURL,
    required this.sessionExpertName,
    required this.sessionReviewSubmitted,
    required this.sessionTime,
    required this.sessionTherapyType,
    required this.sessionUserUID,
    required this.sessionUserImageURL,
    required this.sessionUserName,
    required this.sessionUserGender,
    required this.sessionUID,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json, String docID) {
    return SessionModel(
      sessionAmountPaid: json['amountPaid'],
      sessionExpertUID: json['doctorID'],
      sessionExpertName: json['doctorName'],
      sessionExpertImageURL: json['doctorImgUrl'],
      sessionTime: json['slotTime'],
      sessionReviewSubmitted: json['gaveReview'],
      sessionTherapyType: json['therapy'],
      sessionUserGender: json['userGender'],
      sessionUserImageURL: json['userImgUrl'],
      sessionUserName: json['userName'],
      sessionUserUID: json['userID'],
      sessionUID: docID,
    );
  }
}
