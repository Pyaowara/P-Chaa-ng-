import 'package:flutter/material.dart';

class MenuScreenBottomBar extends StatelessWidget {
  final bool isLoggedIn;
  final bool isShopOpen;
  final int cartItemCount;
  final double cartTotalPrice;
  final VoidCallback? onTap;

  const MenuScreenBottomBar({
    super.key,
    required this.isLoggedIn,
    required this.isShopOpen,
    required this.cartItemCount,
    required this.cartTotalPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (isLoggedIn && isShopOpen) ? onTap : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5B8FA3),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: (isLoggedIn && isShopOpen)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (cartItemCount != 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  cartItemCount.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5B8FA3),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "ออร์เดอร์ของฉัน",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "฿${cartTotalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      (isShopOpen ? "ต้อง Login ก่อน" : "ร้านยังไม่เปิด"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
