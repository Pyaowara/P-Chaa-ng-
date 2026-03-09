import 'package:flutter/material.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/services/app_services.dart';
import 'package:pchaa_client/pchaa_client.dart';

class StoreStatusBanner extends StatelessWidget {
  final bool isOpen;
  final StoreSettings store;

  const StoreStatusBanner({
    super.key,
    required this.isOpen,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.success : AppColors.error,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 7,
            child: Text(
              isOpen ? "ร้านเปิด" : "ร้านปิด",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 1,
            child: Text(
              "เปิด ${store.openTime.substring(0, 5)} - ${store.closeTime.substring(0, 5)}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
