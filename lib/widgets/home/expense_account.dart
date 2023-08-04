// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

// providers
import 'package:hyper_log/providers/account.dart';

class ExpenseAccount extends StatefulWidget {
  const ExpenseAccount({super.key});

  @override
  State<ExpenseAccount> createState() => _ExpenseAccountState();
}

class _ExpenseAccountState extends State<ExpenseAccount> {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    return SizedBox(
      height: 53,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(255, 51, 102, 1)),
          child: const Icon(Icons.wallet, color: Colors.white),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'دفتر خرج شخصی',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Text(
                    Amount.toSeparator(account.balance),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: account.balance > 0
                          ? const Color.fromRGBO(40, 204, 158, 1)
                          : const Color.fromRGBO(255, 51, 102, 1),
                    ),
                  ),
                ),
                Text(
                  'تومان',
                  style: TextStyle(
                    fontSize: 14,
                    color: account.balance > 0
                        ? const Color.fromRGBO(40, 204, 158, 1)
                        : const Color.fromRGBO(255, 51, 102, 1),
                  ),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
