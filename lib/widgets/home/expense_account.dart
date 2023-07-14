// packages
import 'package:flutter/material.dart';

class ExpenseAccount extends StatelessWidget {
  const ExpenseAccount(this.balance, {super.key});

  final int balance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 48,
          height: 48,
          color: const Color.fromRGBO(255, 51, 102, 1),
          child: const Icon(Icons.wallet, color: Colors.white),
        ),
        Column(
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
                    balance.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 204, 158, 1),
                    ),
                  ),
                ),
                Text(
                  'تومان',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(40, 204, 158, 1),
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
