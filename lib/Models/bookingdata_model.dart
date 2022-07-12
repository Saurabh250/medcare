class BookingAmountModel {
  final String bookingCurrency;
  final dynamic bookingInitialAmount;
  final dynamic bookingDiscount;
  final dynamic bookingMRPDiscount;
  final dynamic bookingAmount;
  final dynamic bookingGatewayCharges;
  String bookingOrderID;

  BookingAmountModel({
    required this.bookingCurrency,
    this.bookingInitialAmount,
    this.bookingDiscount,
    this.bookingMRPDiscount,
    required this.bookingOrderID,
    this.bookingGatewayCharges,
    this.bookingAmount,
  });

  factory BookingAmountModel.fromJson(Map<String, dynamic> json) {
    return BookingAmountModel(
      bookingCurrency: json['currency'],
      bookingInitialAmount: json['initialAmount'],
      bookingDiscount: json['discountAmount'],
      bookingMRPDiscount: json['mrpDiscount'],
      bookingGatewayCharges: json['gatewayCharges'],
      bookingAmount: json['amount'],
      bookingOrderID: json['order_id'],
    );
  }
}
