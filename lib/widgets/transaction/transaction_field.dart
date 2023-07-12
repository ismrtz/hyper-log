import 'package:flutter/material.dart';

class TransactionField extends StatelessWidget {
  const TransactionField(
      {required this.field, required this.onTapTransaction, super.key});

  final Map field;
  final Function onTapTransaction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapTransaction(field['name']),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        field['label'],
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Icon(
                            field['icon'],
                            color: field.containsKey('color')
                                ? field['color']
                                : Colors.grey,
                            size: 32,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
