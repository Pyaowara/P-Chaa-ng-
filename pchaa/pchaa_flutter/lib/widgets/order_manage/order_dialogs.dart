import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'order_constants.dart';

/// Dialog helpers for order status management
class OrderDialogs {
  /// Show confirmation dialog for status change
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required OrderStatus newStatus,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ยืนยันการเปลี่ยนสถานะ'),
          content: Text(
            'เปลี่ยนสถานะเป็น ${OrderConstants.formatOrderStatus(newStatus)} ใช่หรือไม่?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: OrderConstants.getStatusColor(newStatus),
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text(
                'ยืนยัน',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show reply message modal for cancellation
  static Future<void> showReplyMessageDialog({
    required BuildContext context,
    required Function(String?) onConfirm,
  }) {
    final replyController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.large),
          topRight: Radius.circular(AppRadius.large),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'ข้อความปฎิเสธ',
                    style: AppTextStyles.sectionTitle,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'เขียนข้อความตอบกลับไปยังลูกค้า (ถ้ามี)',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: replyController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'เขียนข้อความที่นี่...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('ยกเลิก'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              onConfirm(
                                replyController.text.isEmpty
                                    ? null
                                    : replyController.text,
                              );
                            },
                            child: const Text(
                              'ปฎิเสธ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
