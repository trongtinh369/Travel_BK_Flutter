import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:flutter/material.dart';

class ScheduleTourmanagerCard extends StatelessWidget {
  final ScheduleTourmanager shedule_tour_manager;
  final VoidCallback onDelete;

  const ScheduleTourmanagerCard({
    required this.shedule_tour_manager,
    required this.onDelete,
  });

  String _formatDate(DateTime d) {
    two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.chiTietLichTrinh,
          arguments: shedule_tour_manager,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        (shedule_tour_manager.tour.tourImages.isNotEmpty &&
                                shedule_tour_manager.tour.tourImages.first
                                    .toString()
                                    .isNotEmpty)
                            ? Image.network(
                              shedule_tour_manager.tour.tourImages.first
                                  .toString(),
                              width: 110,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 110,
                                  height: 80,
                                  color: AppColors.gray.withOpacity(0.3),
                                  child: const Icon(
                                    Icons.image,
                                    color: AppColors.gray,
                                  ),
                                );
                              },
                            )
                            : Container(
                              width: 110,
                              height: 80,
                              color: AppColors.gray.withOpacity(0.3),
                              child: const Icon(
                                Icons.image,
                                color: AppColors.gray,
                              ),
                            ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _formatDate(shedule_tour_manager.startDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDate(shedule_tour_manager.endDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                (shedule_tour_manager.tour.provinces.isNotEmpty
                                    ? shedule_tour_manager
                                        .tour
                                        .provinces
                                        .first
                                        .name
                                    : ""),

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.park,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                shedule_tour_manager.tour.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.group,
                              size: 16,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 6),
                            Text('Tối đa: ${shedule_tour_manager.maxSlot}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Xóa'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
