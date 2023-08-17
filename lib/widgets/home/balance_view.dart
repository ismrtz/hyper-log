// packages
import 'package:flutter/material.dart';
import 'package:hyper_log/screens/dashboard.dart';

// widgets
import 'package:hyper_log/widgets/global/balance_chart.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  int selectedButtonIndex = 0;
  List<Map> buttons = [
    {'name': 'settings', 'label': 'همین ماه', 'disabled': false},
    {'name': 'profile', 'label': 'همین هفته', 'disabled': true},
    {'name': 'tip', 'label': 'امروز', 'disabled': true}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(12, 29, 27, 1),
          borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buttons.map((button) {
                  final index = buttons.indexOf(button);
                  return SizedBox(
                    width: 103,
                    child: TextButton(
                      style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 10)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          backgroundColor: MaterialStatePropertyAll(
                              selectedButtonIndex == index
                                  ? const Color.fromRGBO(40, 204, 158, 1)
                                  : const Color.fromRGBO(19, 47, 43, 1))),
                      onPressed: button['disabled']
                          ? null
                          : () => setState(() {
                                selectedButtonIndex = index;
                              }),
                      child: Text(
                        button['label'],
                        style: TextStyle(
                            fontSize: 16,
                            color: button['disabled']
                                ? Colors.grey[600]
                                : selectedButtonIndex == index
                                    ? Colors.white
                                    : Colors.grey[200]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const BalanceChart(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            color: Colors.grey[800],
          ),
        ),
        InkWell(
          onTap: () => selectedPageIndexGlobal.value = 1,
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مشاهده تراکنش‌ها',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Colors.white70,
                ),
              ]),
        )
      ]),
    );
  }
}
