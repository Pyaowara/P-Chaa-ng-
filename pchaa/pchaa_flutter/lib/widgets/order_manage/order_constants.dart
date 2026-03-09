import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';

/// Helper class for order-related formatting and colors
class OrderConstants {
  OrderConstants._();

  static String formatOrderStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.ordered:
        return 'สั่งแล้ว';
      case OrderStatus.confirmed:
        return 'ยืนยันแล้ว';
      case OrderStatus.preparing:
        return 'กำลังเตรียม';
      case OrderStatus.finished:
        return 'เสร็จสิ้น';
      case OrderStatus.received:
        return 'ลูกค้ารับแล้ว';
      case OrderStatus.cancelled:
        return 'ยกเลิก';
    }
  }

  static String formatOrderType(OrderType type) {
    switch (type) {
      case OrderType.I:
        return 'สั่งทันที';
      case OrderType.S:
        return 'สั่งกำหนดเวลา';
    }
  }

  static Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.ordered:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.finished:
        return AppColors.success;
      case OrderStatus.received:
        return Colors.green;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }
}
