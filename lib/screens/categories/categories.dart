// screens
import 'package:hyper_log/widgets/category/category_list.dart';

import './new_category.dart';

// packages
import 'package:flutter/material.dart';

//models
import 'package:hyper_log/models/category.dart';

//services
import 'package:hyper_log/services/categories_sqlite_service.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  static const routeName = '/categories';

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isActiveReceiptTab = true;
  List<Category> categories = [];

  late CategoriesSqliteService _categoriesSqliteService;

  @override
  void initState() {
    super.initState();

    _categoriesSqliteService = CategoriesSqliteService();
    getCategories();
  }

  Future<void> getCategories() async {
    final result = await _categoriesSqliteService.getCategories(null);
    setState(() {
      categories = result;
    });
  }

  List<Category> get paymentCategories {
    return categories.where((category) => category.type == 1).toList();
  }

  List<Category> get receiptCategories {
    return categories.where((category) => category.type == 0).toList();
  }

  void _backScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setReceiptTab() {
    setState(() {
      if (!isActiveReceiptTab) isActiveReceiptTab = true;
    });
  }

  void _setPaymentTab() {
    setState(() {
      if (isActiveReceiptTab) isActiveReceiptTab = false;
    });
  }

  void _openNewResourcePage(BuildContext context) {
    Navigator.of(context).pushNamed(NewCategory.routeName);
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16)),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromRGBO(19, 47, 43, 1))),
                            onPressed: () => _openNewResourcePage(context),
                            icon: const Icon(
                              Icons.add,
                              color: Color.fromRGBO(40, 204, 158, 1),
                            ),
                            label: const Text(
                              'جدید',
                              style: TextStyle(
                                  color: Color.fromRGBO(40, 204, 158, 1),
                                  fontSize: 16),
                            )),
                        Text('دسته‌بندی',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade200)),
                        IconButton(
                          onPressed: () => _backScreen(context),
                          icon: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.grey.shade200,
                            size: 32,
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  height: MediaQuery.of(context).size.height - 146,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(12, 29, 27, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 4,
                                            color: isActiveReceiptTab
                                                ? const Color.fromRGBO(
                                                    25, 107, 105, 1)
                                                : Colors.transparent))),
                                child: TextButton(
                                    onPressed: _setReceiptTab,
                                    child: Text(
                                      'پرداختی',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: isActiveReceiptTab
                                              ? Colors.white
                                              : Colors.white54),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 4,
                                            color: !isActiveReceiptTab
                                                ? const Color.fromRGBO(
                                                    25, 107, 105, 1)
                                                : Colors.transparent))),
                                child: TextButton(
                                    onPressed: _setPaymentTab,
                                    child: Text(
                                      'دریافتی',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: !isActiveReceiptTab
                                              ? Colors.white
                                              : Colors.white54),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 24),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white54,
                                  )),
                              const Icon(
                                Icons.tune,
                                color: Colors.white54,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[800]),
                    isActiveReceiptTab
                        ? CategoryList(
                            height: MediaQuery.of(context).size.height - 246,
                            categories: receiptCategories,
                            selectCategory: () {})
                        : CategoryList(
                            height: MediaQuery.of(context).size.height - 246,
                            categories: paymentCategories,
                            selectCategory: () {})
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
