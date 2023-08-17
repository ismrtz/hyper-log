// packages
import 'package:flutter/material.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

class TrnsactionsCard extends StatelessWidget {
  const TrnsactionsCard(
      {required this.title,
      required this.color,
      required this.amount,
      super.key});

  final int amount;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 173),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 4),
            borderRadius: BorderRadius.circular(24)),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Amount.toSeparator(amount),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
