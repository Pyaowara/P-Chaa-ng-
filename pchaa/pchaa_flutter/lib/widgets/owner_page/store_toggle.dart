import 'package:flutter/material.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';

class StoreToggle extends StatelessWidget {
  final bool isOpen;
  final bool isToggling;
  final VoidCallback onToggle;

  const StoreToggle({
    super.key,
    required this.isOpen,
    required this.isToggling,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isToggling ? null : onToggle,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        padding: const EdgeInsets.all(12),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: isOpen ? AppColors.success : AppColors.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isOpen ? "ร้านเปิด" : "ร้านปิด",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (isToggling)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else
              Icon(
                isOpen ? Icons.toggle_on : Icons.toggle_off,
                size: 36,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
