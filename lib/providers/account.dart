// packages
import 'package:flutter/material.dart';
import 'package:hyper_log/services/transactions_sqlite_service.dart';

class Account with ChangeNotifier {
  int _balance = 0;

  final _transactionsSqliteService = TransactionsSqliteService();

  int get balance => _balance;

  Future<void> getBalance() async {
    final result = await _transactionsSqliteService.getTotalAmount();

    _balance = result[0]['amount'] ?? 0;
    notifyListeners();
  }
}
