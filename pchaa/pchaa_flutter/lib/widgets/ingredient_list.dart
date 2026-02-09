import 'package:flutter/material.dart';
import 'package:pchaa_client/pchaa_client.dart';

class IngredientList extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const IngredientList({
    super.key,
    required this.ingredient,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF5B8FA3).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          title: Text(
            ingredient.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: SizedBox(
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ingredient.isAvailable
                        ? Colors.green.withOpacity(0.15)
                        : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: ingredient.isAvailable ? Colors.green : Colors.red,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    ingredient.isAvailable ? 'มีวัตถุดิบ' : 'วัตถุดิบหมด',
                    style: TextStyle(
                      fontSize: 11,
                      color: ingredient.isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.edit, size: 18),
                    color: const Color(0xFF5B8FA3),
                    onPressed: onEditPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
