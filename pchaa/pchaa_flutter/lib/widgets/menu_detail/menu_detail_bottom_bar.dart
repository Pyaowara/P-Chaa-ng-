import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';
import 'package:pchaa_flutter/services/app_services.dart';

class MenuDetailBottomBar extends StatelessWidget {
  final int quantity;
  final bool isLogin;
  final AvailableMenuItem? menuDetail;
  final bool isShopOpened;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback? onAddToCart;
  final double basePrice;
  final double addOnTotal;
  final Color primaryColor;

  const MenuDetailBottomBar({
    super.key,
    required this.isLogin,
    required this.isShopOpened,
    required this.quantity,
    required this.menuDetail,
    required this.onQuantityChanged,
    required this.basePrice,
    required this.addOnTotal,
    required this.primaryColor,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    if (googleAuthService.userData?.role == UserRole.owner) {
      return const SizedBox.shrink();
    }
    final total = (basePrice + addOnTotal) * quantity;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 1),
            width: 0.5,
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: quantity > 1 && isLogin
                    ? () => onQuantityChanged(quantity - 1)
                    : null,
                icon: const Icon(Icons.remove),
                style: const ButtonStyle(),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: isLogin ? () => onQuantityChanged(quantity + 1) : null,
                icon: const Icon(Icons.add),
                style: const ButtonStyle(),
              ),
            ],
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: isShopOpened && quantity > 0 && menuDetail?.forSale == true && isLogin ? onAddToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add To Cart",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
