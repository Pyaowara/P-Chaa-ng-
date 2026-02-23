import 'package:flutter/material.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';

class StoreTimePickers extends StatelessWidget {
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final VoidCallback onPickOpenTime;
  final VoidCallback onPickCloseTime;

  const StoreTimePickers({
    super.key,
    required this.openTime,
    required this.closeTime,
    required this.onPickOpenTime,
    required this.onPickCloseTime,
  });

  String _displayTime(TimeOfDay t) {
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: _TimeCard(
              label: 'เวลาเปิด',
              time: _displayTime(openTime),
              onTap: onPickOpenTime,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _TimeCard(
              label: 'เวลาปิด',
              time: _displayTime(closeTime),
              onTap: onPickCloseTime,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final String label;
  final String time;
  final VoidCallback onTap;

  const _TimeCard({
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
