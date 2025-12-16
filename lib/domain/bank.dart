class Bank {
  final int id;
  final String name;

  Bank({
    required this.id,
    required this.name,
  });

  static Bank empty() {
    return Bank(
      id: 0,
      name: '',
    );
  }
}
