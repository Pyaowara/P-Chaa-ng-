import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';

class OrderListFilters extends StatelessWidget {
  final OrderType? selectedType;
  final OrderStatus? selectedStatus;
  final ValueChanged<OrderType?> onTypeChanged;
  final ValueChanged<OrderStatus?> onStatusChanged;

  const OrderListFilters({
    super.key,
    required this.selectedType,
    required this.selectedStatus,
    required this.onTypeChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Filter by type
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ประเภท',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButton<OrderType?>(
                value: selectedType,
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: AppColors.primary,
                ),
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('ทั้งหมด', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderType.I,
                    child: Text('สั่งทันที', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderType.S,
                    child: Text('สั่งกำหนด', style: TextStyle(fontSize: 13)),
                  ),
                ],
                onChanged: onTypeChanged,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Filter by status
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'สถานะ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              DropdownButton<OrderStatus?>(
                value: selectedStatus,
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: AppColors.primary,
                ),
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('ทั้งหมด', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.ordered,
                    child: Text('สั่งแล้ว', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.confirmed,
                    child: Text('ยืนยัน', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.preparing,
                    child: Text('เตรียม', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.finished,
                    child: Text('เสร็จ', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.received,
                    child: Text('รับแล้ว', style: TextStyle(fontSize: 13)),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.cancelled,
                    child: Text('ยกเลิก', style: TextStyle(fontSize: 13)),
                  ),
                ],
                onChanged: onStatusChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
