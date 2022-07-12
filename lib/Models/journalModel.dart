class JournalModel {
  final String journalBody;
  final String journalTitle;
  final String userID;
  final color;

  JournalModel({
    required this.journalBody,
    required this.journalTitle,
    required this.userID,
    required this.color,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      journalBody: json['body'],
      journalTitle: json['title'],
      userID: json['userID'],
      color: json['color'],
    );
  }
}
