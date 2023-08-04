// packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// widgets
import 'package:hyper_log/widgets/more/menu_item.dart';
import 'package:hyper_log/widgets/home/expense_account.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  List<Map> tabs = [
    {
      'selected': true,
      'name': 'settings',
      'label': 'تنظیمات',
      'disabled': false
    },
    {'selected': false, 'name': 'profile', 'label': 'انتقال', 'disabled': true},
    {'selected': false, 'name': 'tip', 'label': 'راهنما', 'disabled': true}
  ];

  List<Map> settingsMenu = [
    {
      'label': 'پرداختی',
      'route': '/new-transaction',
      'arguments': {'action': 'payment'},
      'color': const Color.fromRGBO(255, 51, 402, 1),
      'icon': Icons.arrow_outward,
    },
    {
      'label': 'انتقال',
      'route': '/new-transaction',
      'arguments': {'action': 'transfer'},
      'color': const Color.fromRGBO(51, 187, 255, 1),
      'icon': Icons.swap_horiz,
    },
    {
      'label': 'دریافتی',
      'route': '/new-transaction',
      'arguments': {'action': 'receipt'},
      'color': const Color.fromRGBO(40, 204, 158, 1),
      'icon': Icons.arrow_downward,
    },
    {
      'label': 'منابع خرج',
      'route': '/resources',
      'color': Colors.deepPurple[700],
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'label': 'دسته‌بندی‌ها',
      'route': '/categories',
      'color': Colors.amber,
      'icon': Icons.grid_view,
    }
  ];

  dynamic get selectedTab {
    return tabs.where((button) => button['selected']).toList();
  }

  void _exitApp() {
    SystemNavigator.pop();
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
                  padding: const EdgeInsets.only(
                      top: 24, right: 24, bottom: 16, left: 24),
                  child: Column(
                    children: [
                      Row(
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
                      Container(
                        height: 76,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(12, 29, 27, 1),
                            borderRadius: BorderRadius.circular(24)),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 1 / 0.4),
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  backgroundColor: MaterialStatePropertyAll(
                                      tabs[index]['selected']
                                          ? const Color.fromRGBO(
                                              40, 204, 158, 1)
                                          : Colors.transparent)),
                              onPressed: tabs[index]['disabled']
                                  ? null
                                  : () {
                                      setState(() {
                                        for (var tab in tabs) {
                                          tab['selected'] = false;
                                        }
                                        tabs[index]['selected'] = true;
                                      });
                                    },
                              child: Text(
                                tabs[index]['label'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: tabs[index]['disabled']
                                        ? Colors.grey[600]
                                        : tabs[index]['selected']
                                            ? Colors.white
                                            : Colors.grey[200]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                    children: settingsMenu
                        .map((item) => MenuItem(item: item))
                        .toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
