class ValidateHelper {
  static bool kiemTraSoDienThoai(String soDienThoai) {
    RegExp regexVN = RegExp(r'^(84|0[35789])([0-9]{8})$');

    return regexVN.hasMatch(soDienThoai);
  }

  static bool kiemTraSo(String value) {
    final so = int.tryParse(value);
    return so != null;
  }

  static bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }
}
