import 'package:flutter/material.dart';

enum HinhThuc { thanhtoantoanbo, coc }

class PaymentRadioGroup extends StatefulWidget {
  final Function(HinhThuc) onChangedHinhThuc;

  const PaymentRadioGroup({super.key, required this.onChangedHinhThuc});

  @override
  State<PaymentRadioGroup> createState() => _PaymentRadioGroupState();
}

class _PaymentRadioGroupState extends State<PaymentRadioGroup> {
  HinhThuc? hinhThuc = HinhThuc.thanhtoantoanbo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Radio 1: Thanh toán toàn bộ
        buildRadioOption(
          value: HinhThuc.thanhtoantoanbo,
          icon: Icons.credit_card,
          iconColor: Colors.blue,
          label: 'Thanh toán toàn bộ',
        ),

        const SizedBox(height: 12),

        // Radio 2: Đặt cọc
        buildRadioOption(
          value: HinhThuc.coc,
          icon: Icons.wallet,
          iconColor: Colors.orange,
          label: 'Đặt cọc',
        ),
      ],
    );
  }

  Widget buildRadioOption({
    required HinhThuc value,
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    bool isSelected = hinhThuc == value;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? const Color(0xFF0D9488) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<HinhThuc>(
        value: value,
        groupValue: hinhThuc,
        onChanged: (HinhThuc? newValue) {
          setState(() {
            hinhThuc = newValue;
          });

          widget.onChangedHinhThuc(newValue!);
        },
        title: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        activeColor: const Color(0xFF0D9488),
      ),
    );
  }
}
