import 'package:intl/intl.dart';

String formatCurrency(num value) {
  final formatter = NumberFormat("#,###", "vi_VN");
  return formatter.format(value);
}

String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
