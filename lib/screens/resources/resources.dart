// screens
import 'new_resource.dart';

// packages
import 'package:flutter/material.dart';

// services
// import 'package:hyper_log/services/transactions_sqlite_service.dart';
// import 'package:hyper_log/services/resources_sqlite_service.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  static const routeName = '/resources';

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  bool isActiveBankTab = true;
  late List<Map> resources;

  // late TransactionsSqliteService _transactionsSqliteService;
  // late ResourcesSqliteService _resourcesSqliteService;

  @override
  void initState() {
    super.initState();

    // _transactionsSqliteService = TransactionsSqliteService();
    // _resourcesSqliteService = ResourcesSqliteService();

    // getResources();
    // getTransactions();
    // getResour();
  }

  // Future<void> getResources() async {
  //   final result = await _transactionsSqliteService.getResourcesWithCredit();
  //   print('result😂');
  //   print(result);
  //   setState(() {
  //     resources = result;
  //   });
  // }

  // Future<void> getTransactions() async {
  //   final result = await _transactionsSqliteService.getTransactions(null);
  //   print('txn😎');
  //   print(result);
  // }

  // Future<void> getResour() async {
  //   final result = await _resourcesSqliteService.getResources(null);
  //   print('resources😑');
  //   print(result);
  // }

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setBankTab() {
    setState(() {
      if (!isActiveBankTab) isActiveBankTab = true;
    });
  }

  void _setCashTab() {
    setState(() {
      if (isActiveBankTab) isActiveBankTab = false;
    });
  }

  void _openNewResourcePage(BuildContext context) {
    Navigator.of(context).pushNamed(NewResource.routeName);
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
                        Text('منابع خرج',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade200)),
                        IconButton(
                          onPressed: () => _closeScreen(context),
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
                                            color: isActiveBankTab
                                                ? const Color.fromRGBO(
                                                    25, 107, 105, 1)
                                                : Colors.transparent))),
                                child: TextButton(
                                    onPressed: _setBankTab,
                                    child: Text(
                                      'بانکی',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: isActiveBankTab
                                              ? Colors.white
                                              : Colors.white54),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 4,
                                            color: !isActiveBankTab
                                                ? const Color.fromRGBO(
                                                    25, 107, 105, 1)
                                                : Colors.transparent))),
                                child: TextButton(
                                    onPressed: _setCashTab,
                                    child: Text(
                                      'نقد',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: !isActiveBankTab
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
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Hello',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
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
