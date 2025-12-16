class Role {
  final int id;
  final String title;

  Role({required this.id, required this.title});

  static Role empty() {
    return Role(id: 0, title: '');
  }
}
