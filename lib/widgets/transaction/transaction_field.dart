// packages
import 'package:flutter/material.dart';

class TransactionField extends StatelessWidget {
  const TransactionField(
      {required this.field, required this.onTapTransaction, super.key});

  final Map field;
  final Function onTapTransaction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTapTransaction(context, field['name']),
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
                          field['title'],
                          style: TextStyle(
                              color: field.containsKey('color')
                                  ? Colors.grey[200]
                                  : Colors.grey,
                              fontSize: 16),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: field.containsKey('color')
                                    ? Color(int.parse(field['color']))
                                    : Colors.transparent,
                              ),
                              child: Icon(
                                IconData(int.parse(field['icon']),
                                    fontFamily: 'MaterialIcons'),
                                color: field.containsKey('color')
                                    ? Colors.white
                                    : Colors.grey,
                              ),
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
      ),
    );
  }
}
