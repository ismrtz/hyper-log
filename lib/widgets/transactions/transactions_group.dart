// packages
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

// widgets
import 'package:hyper_log/widgets/transactions/transaction_item.dart';

class TransactionsGroup extends StatelessWidget {
  const TransactionsGroup({required this.transactions, super.key});

  final Map transactions;

  int get totalAmount {
    final List<dynamic> amountList =
        transactions['Txns'].map((txn) => txn['amount']).toList();
    return amountList.reduce((prev, value) => prev + value);
  }

  @override
  Widget build(BuildContext context) {
    final date =
        Jalali.fromDateTime(DateTime.parse(transactions['date'])).formatter;
    final String jalaliDate = '${date.wN} ${date.d} ${date.mN} ${date.yyyy}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.04)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  jalaliDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.48),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Amount.toSeparator(totalAmount.abs()),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (totalAmount != 0)
                      totalAmount > 0
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
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(color: Color.fromRGBO(25, 107, 105, 1)))),
            child: Column(children: [
              ...transactions['Txns']
                  .map((txn) => TransactionItem(transaction: txn))
            ]),
          )
        ],
      ),
    );
  }
}
