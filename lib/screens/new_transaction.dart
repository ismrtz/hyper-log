// packages
import 'package:flutter/material.dart';

// models
import 'package:hyper_log/models/category.dart';
import 'package:hyper_log/models/resource.dart';
import 'package:hyper_log/models/transaction.dart';

// widgets
import 'package:hyper_log/widgets/category/category_list.dart';
import 'package:hyper_log/widgets/resource/resource_list.dart';
import 'package:hyper_log/widgets/transaction/transaction_field.dart';

// services
import '../../services/categories_sqlite_service.dart';
import 'package:hyper_log/services/resources_sqlite_service.dart';
import 'package:hyper_log/services/transactions_sqlite_service.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  static const routeName = '/new-transaction';

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  late String action;
  // late Category selectedCategory;
  late List<Resource> resources;
  late List<Category> categories;
  late ResourcesSqliteService _resourcesSqliteService;
  late CategoriesSqliteService _categoriesSqliteService;
  late TransactionsSqliteService _transactionsSqliteService;

  List<Map> buttonsList = [
    {
      'type': 0,
      'selected': true,
      'name': 'payment',
      'label': 'پرداختی',
      'icon': Icons.arrow_outward,
      'color': const Color.fromRGBO(255, 51, 402, 1),
    },
    {
      'label': 'انتقال',
      'selected': false,
      'name': 'transfer',
      'icon': Icons.swap_horiz,
      'color': const Color.fromRGBO(51, 187, 255, 1),
    },
    {
      'type': 1,
      'name': 'receipt',
      'selected': false,
      'label': 'دریافتی',
      'icon': Icons.arrow_downward,
      'color': const Color.fromRGBO(40, 204, 158, 1),
    },
  ];

  List paymentFields = [
    {
      'name': 'category',
      'title': 'دسته‌بندی پرداختی',
      'icon': '0xf0d7',
    },
    {
      'name': 'resource',
      'title': 'نام منبع خرج',
      'icon': '0xee33',
    },
    // {
    //   'name': 'label',
    //   'title': 'برچسب‌ها',
    //   'icon': '0xe364',
    // },
  ];

  // @override
  // void didChangeDependencies() {
  //   final routeArgs = ModalRoute.of(context)?.settings.arguments as Map;
  //   action = routeArgs['action'];
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();
    _resourcesSqliteService = ResourcesSqliteService();
    _categoriesSqliteService = CategoriesSqliteService();
    _transactionsSqliteService = TransactionsSqliteService();

    getCategories(selectedTransactionType[0]['type']);
    getRecources();
  }

  Future<void> getCategories(type) async {
    final result = await _categoriesSqliteService.getCategories(type);
    setState(() {
      categories = result;
    });
  }

  Future<void> getRecources() async {
    final result = await _resourcesSqliteService.getResources(null);
    setState(() {
      resources = result;
    });
  }

  dynamic get selectedTransactionType {
    return buttonsList.where((button) => button['selected']).toList();
  }

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void tapTransactionField(BuildContext context, String fieldName) {
    Object bottomSheetList = fieldName == 'category'
        ? CategoryList(
            height: 360, categories: categories, selectCategory: selectCategory)
        : ResourceList(
            height: 360, resources: resources, selectResource: selectResource);
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        backgroundColor: const Color.fromRGBO(12, 29, 27, 1),
        context: context,
        builder: (_) {
          return GestureDetector(child: bottomSheetList as Widget);
        });
  }

  void selectCategory(Category category) {
    final Map field = {
      'id': category.id,
      'name': 'category',
      'icon': category.icon,
      'title': category.title,
      'color': category.color,
    };
    setState(() {
      paymentFields[0] = field;
    });
  }

  void selectResource(Resource resource) {
    final Map field = {
      'id': resource.id,
      'name': 'resource',
      'icon': resource.icon,
      'title': resource.title,
      'color': resource.color
    };

    setState(() {
      paymentFields[1] = field;
    });
  }

  void showSuccessfulMessage() {
    const snackBar = SnackBar(content: Text('تراکنش با موفقیت ساخته شد✅'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> addNewTransaction() async {
    if (selectedTransactionType[0]['name'] == 'transfer') {
    } else {
      addNewPaymentTxn().whenComplete(() {
        showSuccessfulMessage();
        Navigator.of(context).pop(true);
      });
    }
  }

  Future<void> addNewPaymentTxn() async {
    if (paymentFields[0]['color'] != null &&
        paymentFields[1]['color'] != null) {
      final transaction = Transaction(
        amount: selectedTransactionType[0]['name'] == 'payment'
            ? -int.parse(_amountController.text)
            : int.parse(_amountController.text),
        categoryId: paymentFields[0]['id'],
        resourceId: paymentFields[1]['id'],
        createdAt: DateTime.now().millisecondsSinceEpoch,
        description: _descriptionController.text,
      );

      return await _transactionsSqliteService.insertTransaction(transaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        child: SafeArea(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => _closeScreen(context),
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[200],
                            size: 32,
                          )),
                      Text(
                        'تراکنش جدید',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    width: 180,
                    margin: const EdgeInsets.only(top: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                hintText: '0',
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                suffixText: 'تومان',
                                prefixText: 'مبلغ:',
                                prefixStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                suffixStyle: TextStyle(
                                    color: selectedTransactionType[0]['color'],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: TextStyle(
                                fontSize: 28,
                                color: selectedTransactionType[0]['color'],
                                fontWeight: FontWeight.bold,
                              ),
                              autofocus: true,
                              controller: _amountController,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                  ),
                  Container(
                    height: 44,
                    margin: const EdgeInsets.only(top: 16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 0,
                              childAspectRatio: 1 / 0.4),
                      itemCount: buttonsList.length,
                      itemBuilder: (context, index) {
                        return Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    backgroundColor: MaterialStatePropertyAll(
                                        buttonsList[index]['selected']
                                            ? const Color.fromRGBO(
                                                19, 47, 43, 1)
                                            : Colors.transparent)),
                                onPressed: () {
                                  for (var button in buttonsList) {
                                    button['selected'] = false;
                                  }
                                  buttonsList[index]['selected'] = true;
                                  getCategories(
                                      selectedTransactionType[0]['type']);
                                },
                                icon: Icon(
                                  buttonsList[index]['icon'],
                                  color: buttonsList[index]['color'],
                                ),
                                label: Text(
                                  buttonsList[index]['label'],
                                  style: TextStyle(
                                      color: buttonsList[index]['selected']
                                          ? Colors.grey[100]
                                          : Colors.grey),
                                )));
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 298,
              padding: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(12, 29, 27, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                children: [
                  ...paymentFields
                      .map((field) => TransactionField(
                            field: field,
                            onTapTransaction: tapTransactionField,
                          ))
                      .toList(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 48,
                          height: 48,
                          child: const Icon(
                            Icons.border_color_outlined,
                            size: 24,
                            color: Colors.white54,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.white54),
                        hintText: 'یادداشت',
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      controller: _descriptionController,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(40, 204, 158, 1),
        onPressed: addNewTransaction,
        child: const Icon(Icons.done),
      ),
    );
  }
}
