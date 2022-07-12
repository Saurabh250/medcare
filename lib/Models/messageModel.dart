class MessageModel {
  final String message;
  final String messageType;
  final String senderID;
  final int timestamp;

  MessageModel({
    required this.message,
    required this.messageType,
    required this.senderID,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      messageType: json['messageType'],
      senderID: json['senderID'],
      timestamp: json['timestamp'],
    );
  }
}
