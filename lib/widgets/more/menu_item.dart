import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({required this.item, super.key});
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: const Color.fromRGBO(12, 29, 27, 1),
              onTap: (() => Navigator.of(context)
                  .pushNamed(item['route'], arguments: item['arguments'])),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Icon(item['icon'],
                                color: item['color'], size: 32)),
                        Text(
                          item['label'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right_sharp,
                      color: Colors.grey,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            indent: 24,
            endIndent: 24,
            color: Colors.grey[800],
          )
        ],
      ),
    );
  }
}
