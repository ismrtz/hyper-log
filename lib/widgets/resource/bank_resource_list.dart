// packages
import 'package:flutter/material.dart';

// data
import 'package:hyper_log/data/bank_list.dart';

class BankResourceList extends StatelessWidget {
  const BankResourceList({required this.selectResource, super.key});

  final Function selectResource;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 360,
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: bankList.length,
          itemBuilder: (context, index) => Directionality(
            textDirection: TextDirection.rtl,
            child: Card(
              color: Colors.transparent,
              child: ListTile(
                onTap: () {
                  selectResource(bankList[index]);
                  Navigator.of(context).pop();
                },
                horizontalTitleGap: 12,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                tileColor: const Color.fromRGBO(255, 255, 255, 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(
                      width: 2, color: Color.fromRGBO(255, 255, 255, 0.24)),
                ),
                leading: CircleAvatar(
                    backgroundColor:
                        Color(int.parse(bankList[index]['color']!)),
                    child: Icon(
                      IconData(int.parse(bankList[index]['icon']!),
                          fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    )),
                title: Text(
                  bankList[index]['title']!,
                  style: TextStyle(
                      color: Colors.grey[200], fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }
}
