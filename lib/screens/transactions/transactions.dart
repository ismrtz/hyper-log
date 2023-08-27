// packages
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// services
import 'package:hyper_log/services/transactions_sqlite_service.dart';

// widgets
import 'package:hyper_log/widgets/transactions/balance_details.dart';
import 'package:hyper_log/widgets/global/payment_categoires_chart.dart';
import 'package:hyper_log/widgets/transactions/transactions_group.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<Map> transactions = [];
  late TransactionsSqliteService _transactionsSqliteService;

  @override
  void initState() {
    super.initState();
    _transactionsSqliteService = TransactionsSqliteService();

    getTransactionsByDay();
  }

  Future<void> getTransactionsByDay() async {
    final result = await _transactionsSqliteService.getTransactionsByDay();
    final mapedList = groupBy(result, (p0) => p0['createdAt']);
    mapedList.forEach(
        (key, value) => transactions.add({'date': key, 'Txns': value}));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('تراکنش‌ها',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade200)),
                            // TextButton.icon(
                            //     style: const ButtonStyle(
                            //       padding: MaterialStatePropertyAll(
                            //           EdgeInsets.symmetric(
                            //               vertical: 10, horizontal: 16)),
                            //     ),
                            //     onPressed: null,
                            //     icon: const Icon(
                            //       Icons.filter_alt_outlined,
                            //       color: Color.fromRGBO(40, 204, 158, 1),
                            //     ),
                            //     label: const Text(
                            //       'فیلتر',
                            //       style: TextStyle(
                            //           color: Color.fromRGBO(40, 204, 158, 1),
                            //           fontSize: 16),
                            //     )),
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 206,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          const BalanceDetails(),
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: PaymentCategoriesChart(),
                          ),
                          if (transactions.isNotEmpty)
                            ...transactions.map((transaction) =>
                                TransactionsGroup(transactions: transaction))
                        ]),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
