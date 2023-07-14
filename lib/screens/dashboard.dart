import '../models/category.dart';
import 'package:flutter/material.dart';
import '../data/default_categories.dart';
import '../services/categories_sqlite_service.dart';

//screens
import './home.dart';
import './more.dart';
import './tools.dart';
import './transactions.dart';
import './new_transaction.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> _pages;
  late List<Category> categories;
  late CategoriesSqliteService _categoriesSqliteService;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [const Home(), const Transactions(), const Tools(), const More()];
    super.initState();

    _categoriesSqliteService = CategoriesSqliteService();

    _categoriesSqliteService.initializeDB().whenComplete(() {
      getCategories().whenComplete(() {
        if (categories.isEmpty) {
          for (var i = 0; i < defaultCategories.length; i++) {
            addCategory(defaultCategories[i]);
          }
        }
      });
    });
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
      _selectedPageIndex = index;
    });
  }

  void _addNewTransaction(BuildContext context) {
    Navigator.of(context).pushNamed(NewTransaction.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedPageIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewTransaction(context),
          backgroundColor: const Color.fromRGBO(40, 204, 158, 1),
          child: const Icon(Icons.add, size: 32),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          onTap: _selectPage,
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color.fromRGBO(40, 204, 158, 1),
          backgroundColor: const Color.fromRGBO(12, 29, 27, 7),
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'خانه',
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'تراکنش',
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
        ));
  }
}
