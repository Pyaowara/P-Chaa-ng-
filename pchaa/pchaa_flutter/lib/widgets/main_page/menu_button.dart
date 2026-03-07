import 'package:flutter/material.dart';
import 'package:pchaa_flutter/constants/app_constants.dart';
import 'package:pchaa_flutter/screens/menu_screen.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? onNavigate;

  const MenuButton({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: ElevatedButton.icon(
        onPressed: () async {
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuScreen(),
            ),
          ).then((_){onNavigate?.call();});
        },
        icon: const Icon(Icons.menu),
        label: const Text(
          'MENU เมนูอาหาร',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
      ),
    );
  }
}
