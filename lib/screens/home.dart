// packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyper_log/widgets/home/balance_view.dart';
import 'package:provider/provider.dart';

// providers
import 'package:hyper_log/providers/account.dart';

// screens
import 'package:hyper_log/screens/resources/new_resource.dart';

// widgets
import 'package:hyper_log/widgets/global/tips.dart';
import 'package:hyper_log/widgets/home/expense_account.dart';
import 'package:hyper_log/widgets/home/resource_card_list.dart';
import 'package:hyper_log/widgets/global/payment_categoires_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final List<Map> resources = [
      ...account.bankResources,
      ...account.cashResources
    ];

    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ExpenseAccount(),
                        IconButton(
                            onPressed: _exitApp,
                            icon: const Icon(
                              size: 32,
                              color: Colors.grey,
                              Icons.logout_outlined,
                            )),
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 211,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      const BalanceView(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 24),
                        child: Column(children: [
                          resources.isNotEmpty
                              ? ResourceCardList(resources: resources)
                              : Tips(
                                  title:
                                      'منبع مالی برای ثبت تراکنش نداری! اضافه کن',
                                  actionTitle: 'منبع مالی جدید',
                                  acitonCallback: () => Navigator.of(context)
                                      .pushNamed(NewResource.routeName)),
                          if (resources.isNotEmpty)
                            const Padding(
                                padding: EdgeInsets.only(top: 32),
                                child: PaymentCategoriesChart())
                        ]),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
