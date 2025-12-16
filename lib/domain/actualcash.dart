class Actualcash {
  final int id;
  final int money;
  final int bookingId;
  final DateTime createdAt;

  Actualcash({
    required this.id,
    required this.money,
    required this.bookingId,
    required this.createdAt,
  });
  static Actualcash empty(){
    return Actualcash(id: 0, money: 0, bookingId: 0, createdAt: DateTime.now());
  }
}
