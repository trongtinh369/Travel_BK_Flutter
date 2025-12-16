import 'package:flutter/material.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 64;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipOval(
            child: user.avatarPath.isNotEmpty
                ? Image.network(
                    user.avatarPath,
                    width: avatarSize,
                    height: avatarSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://cdn-icons-png.flaticon.com/128/847/847969.png',
                        width: avatarSize,
                        height: avatarSize,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.network(
                    'https://cdn-icons-png.flaticon.com/128/847/847969.png',
                    width: avatarSize,
                    height: avatarSize,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
