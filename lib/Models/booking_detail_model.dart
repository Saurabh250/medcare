class BookingDetail {
  final String bookingUserUID;
  final String bookingExpertUID;
  final String bookingSlotTime;
  final String bookingSlotDate;
  final String bookingTherapyName;
  final DateTime bookingSlotTimestamp;

  BookingDetail({
    required this.bookingUserUID,
    required this.bookingSlotTimestamp,
    required this.bookingExpertUID,
    required this.bookingSlotTime,
    required this.bookingSlotDate,
    required this.bookingTherapyName,
  });
}
