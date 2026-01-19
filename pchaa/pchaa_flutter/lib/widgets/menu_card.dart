import 'package:flutter/material.dart';

const List<double> _greyscaleMatrix = <double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
];

const List<double> _identityMatrix = <double>[
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
];

class MenuCard extends StatelessWidget {
  final String? imagePath;
  final String name;
  final double price;
  final VoidCallback? onAdd;
  final bool isDisabled;

  const MenuCard({
    super.key,
    this.imagePath,
    required this.name,
    required this.price,
    this.onAdd,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: isDisabled
          ? const ColorFilter.matrix(_greyscaleMatrix)
          : const ColorFilter.matrix(_identityMatrix),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/food.jpg",
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

          
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '฿$price',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add button
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
