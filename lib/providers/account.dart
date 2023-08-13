// packages
import 'package:flutter/material.dart';
import 'package:hyper_log/services/transactions_sqlite_service.dart';

class Account with ChangeNotifier {
  int _deposite = 0;
  int _withdraw = 0;
  List<Map> _resources = [];
  List<Map> _paymentCategories = [];
  List<Map> _receiptCategories = [];

  final _transactionsSqliteService = TransactionsSqliteService();

  int get deposite => _deposite;
  int get withdraw => _withdraw;
  int get balance => _deposite + _withdraw;

  List<Map> get paymentCategories => _paymentCategories;
  List<Map> get receiptCategories => _receiptCategories;

  List<Map> get bankResources {
    return _resources.where((resource) => resource['type'] == 1).toList();
  }

  List<Map> get cashResources {
    return _resources.where((resource) => resource['type'] == 0).toList();
  }

  Future<void> getBalanceByType() async {
    final result = await _transactionsSqliteService.getAmountByType();
    if (result.isNotEmpty) {
      // ignore: unnecessary_null_comparison
      _deposite = result[0]['amount'] > 0
          ? result[0]['amount']
          : result.length > 1 && result[1]['amount'] > 0
              ? result[1]['amount']
              : _deposite;
      _withdraw = result[0]['amount'] < 0
          ? result[0]['amount']
          : result.length > 1 && result[1]['amount'] < 0
              ? result[1]['amount']
              : _withdraw;
      notifyListeners();
    }
  }

  Future<void> getPaymentCategoires() async {
    final result = await _transactionsSqliteService.getCategoriesWithCount(0);
    _paymentCategories = result;
    notifyListeners();
  }

  Future<void> getReceiptCategoires() async {
    final result = await _transactionsSqliteService.getCategoriesWithCount(1);
    _receiptCategories = result;
    notifyListeners();
  }

  Future<void> getResources() async {
    final result =
        await _transactionsSqliteService.getResourcesWithCredit(null);
    _resources = result;
    notifyListeners();
  }
}
