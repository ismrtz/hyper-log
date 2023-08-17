// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// screens
import 'new_resource.dart';

// providers
import 'package:hyper_log/providers/account.dart';

// widgets
import 'package:hyper_log/widgets/resource/resource_card.dart';

// services
// import 'package:hyper_log/services/transactions_sqlite_service.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  static const routeName = '/resources';

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  bool isActiveBankTab = true;

  // List<Map> resources = [];

  // late TransactionsSqliteService _transactionsSqliteService;

  // @override
  // void initState() {
  //   super.initState();

  // _transactionsSqliteService = TransactionsSqliteService();

  // getResources();
  // }

  // Future<void> getResources() async {
  //   final result =
  //       await _transactionsSqliteService.getResourcesWithCredit(null);
  //   setState(() {
  //     resources = result;
  //   });
  // }

  // List<Map> get bankResources {
  //   return resources.where((resource) => resource['type'] == 1).toList();
  // }

  // List<Map> get cashResources {
  //   return resources.where((resource) => resource['type'] == 0).toList();
  // }

  void _backScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setBankTab() {
    setState(() {
      if (!isActiveBankTab) {
        isActiveBankTab = true;
      }
    });
  }

  void _setCashTab() {
    setState(() {
      if (isActiveBankTab) {
        isActiveBankTab = false;
      }
    });
  }

  void _openNewResourcePage(BuildContext context) {
    Navigator.of(context).pushNamed(NewResource.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);

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
                        Text('منابع مالی',
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 246,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: isActiveBankTab
                                ? account.bankResources.length
                                : account.cashResources.length,
                            itemBuilder: (context, index) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      ResourceCard(
                                        width: double.infinity,
                                        resource: isActiveBankTab
                                            ? account.bankResources[index]
                                            : account.cashResources[index],
                                        selectResource: () {},
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                      )
                                    ],
                                  ),
                                )))
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
