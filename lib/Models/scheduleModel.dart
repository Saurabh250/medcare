// ignore: file_names
class ScheduleModel {
  final List expertSlotLists;
  final Map expertSlotAvailability;

  ScheduleModel({
    required this.expertSlotLists,
    required this.expertSlotAvailability,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      expertSlotLists: json['slotList'],
      expertSlotAvailability: json['slotStatus'],
    );
  }
}
