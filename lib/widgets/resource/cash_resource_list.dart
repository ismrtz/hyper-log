// packages
import 'package:flutter/material.dart';

// data
import 'package:hyper_log/data/cash_list.dart';

class CashResourceList extends StatelessWidget {
  const CashResourceList({required this.selectIcon, super.key});

  final Function selectIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cashList
              .map((cashItem) => Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Color(int.parse(cashItem['color']!))),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(56),
                        onTap: () {
                          selectIcon(cashItem);
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          IconData(int.parse(cashItem['icon']!),
                              fontFamily: 'MaterialIcons'),
                          size: 32,
                          color: Color(int.parse(cashItem['color']!)),
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
