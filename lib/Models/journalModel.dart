class JournalModel {
  final String journalBody;
  final String journalTitle;
  final String userID;

  JournalModel({
    required this.journalBody,
    required this.journalTitle,
    required this.userID,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      journalBody: json['body'],
      journalTitle: json['title'],
      userID: json['userID'],
    );
  }
}
