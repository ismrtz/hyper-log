// screens
import './home.dart';
import './more.dart';
import './tools.dart';
import 'transactions/transactions.dart';
import 'transactions/new_transaction.dart';

// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//models
import 'package:hyper_log/models/category.dart';

// providers
import 'package:hyper_log/providers/account.dart';

// data
import 'package:hyper_log/data/default_categories.dart';

// services
import 'package:hyper_log/services/sqlite_service.dart';
import 'package:hyper_log/services/categories_sqlite_service.dart';

ValueNotifier selectedPageIndexGlobal = ValueNotifier(0);

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> _pages;
  late List<Category> categories;
  late SqliteService _sqliteService;
  late CategoriesSqliteService _categoriesSqliteService;

  @override
  void initState() {
    _pages = [const Home(), const Transactions(), const Tools(), const More()];
    super.initState();

    _sqliteService = SqliteService();
    _categoriesSqliteService = CategoriesSqliteService();

    _sqliteService.initializeDB().whenComplete(() {
      getCategories().whenComplete(() {
        if (categories.isEmpty) {
          for (var i = 0; i < defaultCategories.length; i++) {
            addCategory(defaultCategories[i]);
          }
        }
      });
    });

    final account = Provider.of<Account>(context, listen: false);

    account.getBalanceByType('-30');
    account.getPaymentCategoires();
    account.getReceiptCategoires();
    account.getResources();
  }

  Future<void> getCategories() async {
    final result = await _categoriesSqliteService.getCategories(null);
    categories = result;
  }

  Future<void> addCategory(Category category) async {
    return await _categoriesSqliteService.insertCategory(category);
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndexGlobal.value = index;
    });
  }

  void _addNewTransaction(BuildContext context) {
    Navigator.of(context).pushNamed(NewTransaction.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageIndexGlobal,
      builder: (context, val, child) => Scaffold(
          body: _pages[selectedPageIndexGlobal.value],
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addNewTransaction(context),
            backgroundColor: const Color.fromRGBO(40, 204, 158, 1),
            child: const Icon(Icons.add, size: 32),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            onTap: _selectPage,
            unselectedItemColor: Colors.grey,
            selectedItemColor: const Color.fromRGBO(40, 204, 158, 1),
            backgroundColor: const Color.fromRGBO(12, 29, 27, 7),
            currentIndex: selectedPageIndexGlobal.value,
            items: const [
              BottomNavigationBarItem(
                label: 'خانه',
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: 'تراکنش‌ها',
                activeIcon: Icon(Icons.receipt_long),
                icon: Icon(Icons.receipt_long_outlined),
              ),
              BottomNavigationBarItem(
                label: 'ابزارها',
                activeIcon: Icon(Icons.build),
                icon: Icon(Icons.build_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: 'بیشتر',
              ),
            ],
          )),
    );
  }
}
