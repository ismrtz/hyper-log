// packages
import 'package:flutter/material.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({required this.transaction, super.key});

  final Map transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 20, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(int.parse(transaction['color']))),
                child: Icon(
                  IconData(int.parse(transaction['icon']),
                      fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
              ),
              Text(
                transaction['title'],
                style: const TextStyle(fontSize: 16, color: Colors.white),
              )
            ],
          ),
          Row(
            children: [
              Text(
                Amount.toSeparator(transaction['amount'].abs()),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (transaction['amount'] != 0)
                transaction['amount'] > 0
                    ? const Icon(
                        Icons.add,
                        size: 16,
                        color: Color.fromRGBO(40, 204, 158, 1),
                      )
                    : const Icon(
                        Icons.remove,
                        size: 16,
                        color: Color.fromRGBO(255, 51, 102, 1),
                      )
            ],
          )
        ],
      ),
    );
  }
}
