// packages
import 'package:flutter/material.dart';

// services
import 'package:hyper_log/services/transactions_sqlite_service.dart';

class ExpenseAccount extends StatefulWidget {
  const ExpenseAccount({super.key});

  @override
  State<ExpenseAccount> createState() => _ExpenseAccountState();
}

class _ExpenseAccountState extends State<ExpenseAccount> {
  int balance = 0;

  late TransactionsSqliteService _transactionsSqliteService;

  @override
  void initState() {
    super.initState();
    _transactionsSqliteService = TransactionsSqliteService();

    getTotalAmount();
  }

  Future<void> getTotalAmount() async {
    final result = await _transactionsSqliteService.getTotalAmount();

    setState(() {
      balance = result[0]['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    balance.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(40, 204, 158, 1),
                    ),
                  ),
                ),
                const Text(
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
