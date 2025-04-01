import 'package:flutter/material.dart';
import 'package:online_groceries_app/utils/constants.dart';

class AddAndRemove extends StatelessWidget {
  final bool hasBorder; // Controls border for buttons
  final bool quantityBorder; // Controls border for quantity display
  final int quantity; // Quantity value passed from parent
  final VoidCallback onAdd; // Callback for adding quantity
  final VoidCallback onRemove; // Callback for removing quantity

  const AddAndRemove({
    super.key,
    required this.hasBorder,
    required this.quantityBorder,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Remove Button
        GestureDetector(
          onTap: onRemove,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: hasBorder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  )
                : null, // No border
            child: const Icon(
              Icons.remove,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ),

        // Quantity Display
        quantityBorder
            ? Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

        // Add Button
        GestureDetector(
          onTap: onAdd,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: hasBorder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  )
                : null, // No border
            child: const Icon(
              Icons.add,
              size: 25,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
