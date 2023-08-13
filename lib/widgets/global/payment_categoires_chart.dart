// packages
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

// providers
import 'package:hyper_log/providers/account.dart';

// widgets
import 'package:hyper_log/widgets/global/tips.dart';

// screens
import 'package:hyper_log/screens/new_transaction.dart';

class PaymentCategoriesChart extends StatefulWidget {
  const PaymentCategoriesChart({super.key});

  @override
  State<PaymentCategoriesChart> createState() => _PaymentCategoriesChartState();
}

class _PaymentCategoriesChartState extends State<PaymentCategoriesChart> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    return account.paymentCategories.isNotEmpty
        ? Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.insert_chart_outlined,
                    color: Color.fromRGBO(40, 204, 158, 1),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'نمودار پرداختی',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          account.paymentCategories[selectedCategoryIndex]
                                  ['count']
                              .toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          account.paymentCategories[selectedCategoryIndex]
                              ['title'],
                          style: const TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (pieTouchResponse?.touchedSection
                                          ?.touchedSectionIndex !=
                                      null &&
                                  pieTouchResponse?.touchedSection
                                          ?.touchedSectionIndex !=
                                      -1) {
                                setState(() {
                                  selectedCategoryIndex = pieTouchResponse!
                                      .touchedSection!.touchedSectionIndex;
                                });
                              }
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 12,
                          // centerSpaceRadius: double.infinity,
                          sections: account.paymentCategories
                              .map((category) => PieChartSectionData(
                                  value: category['count'].toDouble(),
                                  showTitle: false,
                                  color: Color(int.parse(category['color'])),
                                  badgeWidget: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 6,
                                            spreadRadius: 2,
                                            color: Colors.black38)
                                      ],
                                      border: Border.all(
                                          width: 4,
                                          color: Color(
                                              int.parse(category['color']))),
                                    ),
                                    child: Icon(
                                      IconData(int.parse(category['icon']),
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black87,
                                    ),
                                  ),
                                  badgePositionPercentageOffset: 1))
                              .toList(),
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 300),
                        swapAnimationCurve: Curves.linear,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        : Tips(
            actionTitle: 'تراکنش جدید',
            title: 'تراکنش پرداختی ثبت‌ شده‌ای نداری!',
            acitonCallback: () =>
                Navigator.of(context).pushNamed(NewTransaction.routeName),
          );
  }
}
