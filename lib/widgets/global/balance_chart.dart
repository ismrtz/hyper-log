// packages
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

// providers
import 'package:hyper_log/providers/account.dart';

class BalanceChart extends StatefulWidget {
  const BalanceChart({super.key});

  @override
  State<BalanceChart> createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const Text(
                  'کل',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  account.balance.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 153,
              height: 153,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 12,
                  startDegreeOffset: 135,
                  centerSpaceRadius: 50,
                  // centerSpaceRadius: double.infinity,
                  sections: [
                    PieChartSectionData(
                        value: account.withdraw == 0
                            ? 1
                            : account.withdraw.toDouble().abs(),
                        showTitle: false,
                        color: const Color.fromRGBO(255, 51, 102, 1),
                        badgeWidget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color.fromRGBO(19, 47, 43, 1)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          child: Text(
                            '${account.withdraw.toString()} تومان',
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        badgePositionPercentageOffset: 1),
                    PieChartSectionData(
                        value: account.deposite == 0
                            ? 1
                            : account.deposite.toDouble(),
                        showTitle: false,
                        color: const Color.fromRGBO(40, 204, 158, 1),
                        badgeWidget: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color.fromRGBO(19, 47, 43, 1)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          child: Text(
                            '${account.deposite.toString()} تومان',
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        badgePositionPercentageOffset: 1)
                  ],
                ),
                swapAnimationDuration: const Duration(milliseconds: 300),
                swapAnimationCurve: Curves.linear,
              ),
            )
          ],
        )
      ],
    );
  }
}
