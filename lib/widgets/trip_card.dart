import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../theme/app_colors.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double progress = trip.progress;

    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Icon(
                  trip.isGroup ? Icons.group : Icons.lock,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    trip.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Text(
                  "${(progress * 100).toInt()}%",
                  style: const TextStyle(
                    color: AppColors.progress,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "${trip.packed} of ${trip.total} items packed",
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                color: AppColors.progress,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}