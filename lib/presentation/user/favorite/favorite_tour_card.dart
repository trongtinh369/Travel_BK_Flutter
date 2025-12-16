import 'package:booking_tour_flutter/domain/favorite.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:flutter/material.dart';

class FavoriteTourCard extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;
  final VoidCallback? onTap; // thêm callback khi nhấn vào card

  const FavoriteTourCard({
    Key? key,
    required this.favorite,
    required this.onFavoriteToggle,
    required this.isFavorite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Trip trip = favorite.tour;
    final String? imageUrl =
        (trip.tourImages.isNotEmpty) ? trip.tourImages.first : null;

    return InkWell(
      onTap: onTap, 
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
                        )
                      : _buildImagePlaceholder(),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: Icons.beach_access,
                        iconColor: Colors.green,
                        text: trip.title,
                        isBold: true,
                      ),
                      const SizedBox(height: 6),
                      _buildInfoRow(
                        icon: Icons.local_offer,
                        iconColor: Colors.red,
                        text: '${trip.price} VND /người',
                        textColor: Colors.red,
                      ),
                      const SizedBox(height: 6),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        iconColor: Colors.orange,
                        text: trip.provinces.map((p) => p.name).join(', '),
                        textColor: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 160,
      width: double.infinity,
      color: Colors.grey[200],
      child: const Icon(
        Icons.image,
        size: 56,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String text,
    bool isBold = false,
    Color? textColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}