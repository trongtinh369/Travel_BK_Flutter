import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:flutter/material.dart';

class ListDiaDanhItem extends StatelessWidget {
  final Place diaDanh;
  final VoidCallback onDelete;
  final VoidCallback onSua;

  const ListDiaDanhItem({
    super.key,
    required this.diaDanh,
    required this.onDelete,
    required this.onSua,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        // bấm vào item chuyển qua địa điểm hạot động
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.danhSachHoatDong,
            arguments: diaDanh,
          );
        },

        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconText(
                        Icons.location_on,
                        Colors.red,
                        "Tên địa danh: ${diaDanh.name}",
                      ),
                      const SizedBox(height: 8),
                      _buildIconText(
                        Icons.park,
                        Colors.green,
                        "Tỉnh thành: ${diaDanh.province?.name ?? ""}",
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DeleteButtonWidget(
                      onDelete: onDelete,
                      text: "Xoá",
                      textColor: AppColors.white,
                    ),
                    DeleteButtonWidget(
                      onDelete: onSua,
                      text: "Sửa",
                      backgroundColor: AppColors.borderButton,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    var tmp = text.split(" ");
    var limitedWords = tmp.length > 6 ? tmp.sublist(0, 6) : tmp;
    var str = limitedWords.join(" ");
    if (tmp.length > 6) str += " ...";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            str,
            style: const TextStyle(fontSize: 16),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
