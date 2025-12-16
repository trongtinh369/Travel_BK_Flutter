// ignore_for_file: public_member_api_docs, sort_constructors_first
class PayBooking {
  final int id;
  final int numPeople;
  final String email;
  final String phone;
  final int totalPrice;
  final bool payType;
  final String code;

  PayBooking({
    required this.id,
    required this.numPeople,
    required this.email,
    required this.phone,
    required this.totalPrice,
    required this.payType,
    required this.code,
  });

  static PayBooking empty() {
    return PayBooking(
      id: 0,
      numPeople: 0,
      email: "",
      phone: "",
      totalPrice: 0,
      payType: false,
      code: "",
    );
  }
}
