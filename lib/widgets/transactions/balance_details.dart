// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

// providers
import 'package:hyper_log/providers/account.dart';

// widgets
import 'package:hyper_log/widgets/transactions/transactions_card.dart';

class BalanceDetails extends StatefulWidget {
  const BalanceDetails({super.key});

  @override
  State<BalanceDetails> createState() => _BalanceDetailsState();
}

class _BalanceDetailsState extends State<BalanceDetails> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final List paymentTransactionCountList =
        account.paymentCategories.isNotEmpty
            ? account.paymentCategories
                .map((category) => category['count'])
                .toList()
            : [0];
    final List receiptTransactionCountList =
        account.receiptCategories.isNotEmpty
            ? account.receiptCategories
                .map((category) => category['count'])
                .toList()
            : [0];

    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 12),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(12, 29, 27, 1),
          borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrnsactionsCard(
              amount: account.withdraw.abs(),
              title: 'پرداختی دوره:',
              color: const Color.fromRGBO(255, 51, 102, 1),
            ),
            const SizedBox(width: 20),
            TrnsactionsCard(
              amount: account.deposite,
              title: 'دریافتی دوره:',
              color: const Color.fromRGBO(40, 204, 158, 1),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 16),
          child: Divider(
            color: Colors.grey[800],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'کل دوره:',
                  style: TextStyle(color: Colors.white70),
                ),
                Row(
                  children: [
                    Text(Amount.toSeparator(account.balance.abs()),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    if (account.balance != 0)
                      account.balance > 0
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'تعداد تراکنش پرداختی:',
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                    paymentTransactionCountList
                        .reduce((value, element) => value + element)
                        .toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'تعداد تراکنش دریافتی:',
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                    receiptTransactionCountList
                        .reduce((value, element) => value + element)
                        .toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
