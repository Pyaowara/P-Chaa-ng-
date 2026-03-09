import 'package:flutter/material.dart';

class OrderCancellationReason extends StatelessWidget {
  final String replyMessage;

  const OrderCancellationReason({super.key, required this.replyMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 255, 241, 133),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: Colors.black.withAlpha(120)),
          const Text(
            "สาเหตุที่ยกเลิก: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 208, 135, 0),
            ),
          ),
          Expanded(
            child: Text(
              replyMessage,
              style: const TextStyle(color: Color.fromARGB(255, 208, 135, 0)),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
