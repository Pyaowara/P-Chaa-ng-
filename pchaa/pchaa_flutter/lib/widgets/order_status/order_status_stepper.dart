import 'package:flutter/material.dart';

class OrderStatusStepper extends StatelessWidget {
  final int currentStep;

  const OrderStatusStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          // Icons and connecting line
          Stack(
            children: [
              // Connecting line
              Positioned(
                top: 20,
                left: 45,
                right: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: currentStep > 0
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[300],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: currentStep > 1
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[300],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: currentStep > 2
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              // Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(
                    icon: Icons.shopping_bag,
                    label: 'รับแล้ว',
                    isActive: currentStep >= 0,
                    stepNumber: 0,
                  ),
                  _buildStep(
                    icon: Icons.hourglass_empty,
                    label: 'กำลังทำ',
                    isActive: currentStep >= 1,
                    stepNumber: 1,
                  ),
                  _buildStep(
                    icon: Icons.restaurant,
                    label: 'พร้อมเสิร์ฟ',
                    isActive: currentStep >= 2,
                    stepNumber: 2,
                  ),
                  _buildStep(
                    icon: Icons.check,
                    label: 'เรียบร้อย',
                    isActive: currentStep >= 3,
                    stepNumber: 3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String label,
    required bool isActive,
    required int stepNumber,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
