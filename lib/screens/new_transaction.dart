import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  static const routeName = '/new-transaction';

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController(text: '0');

  List<Map> buttonsList = [
    {
      'selected': true,
      'name': 'payment',
      'label': 'پرداختی',
      'icon': Icons.arrow_outward,
      'color': const Color.fromRGBO(255, 51, 402, 1),
    },
    {
      'label': 'انتقال',
      'selected': false,
      'name': 'transfer',
      'icon': Icons.swap_horiz,
      'color': const Color.fromRGBO(51, 187, 255, 1),
    },
    {
      'name': 'receipt',
      'selected': false,
      'label': 'دریافتی',
      'icon': Icons.arrow_downward,
      'color': const Color.fromRGBO(40, 204, 158, 1),
    },
  ];

  dynamic get selectedTransactionType {
    return buttonsList.where((button) => button['selected']).toList();
  }

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => _closeScreen(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[200],
                      size: 32,
                    )),
                Text(
                  'تراکنش جدید',
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: 180,
              margin: const EdgeInsets.only(top: 24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(25, 107, 105, 1))),
                          suffixText: 'تومان',
                          prefixText: 'مبلغ:',
                          prefixStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          suffixStyle: TextStyle(
                              color: selectedTransactionType[0]['color'],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextStyle(
                          fontSize: 28,
                          color: selectedTransactionType[0]['color'],
                          fontWeight: FontWeight.bold,
                        ),
                        autofocus: true,
                        controller: _amountController,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
            ),
            Container(
              height: 44,
              margin: const EdgeInsets.only(top: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1 / 0.4),
                itemCount: buttonsList.length,
                itemBuilder: (context, index) {
                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              backgroundColor: MaterialStatePropertyAll(
                                  buttonsList[index]['selected']
                                      ? const Color.fromRGBO(19, 47, 43, 1)
                                      : Colors.transparent)),
                          onPressed: () {
                            buttonsList.forEach(
                                (button) => button['selected'] = false);
                            buttonsList[index]['selected'] = true;
                            setState(() {});
                          },
                          icon: Icon(
                            buttonsList[index]['icon'],
                            color: buttonsList[index]['color'],
                          ),
                          label: Text(
                            buttonsList[index]['label'],
                            style: TextStyle(
                                color: buttonsList[index]['selected']
                                    ? Colors.grey[100]
                                    : Colors.grey),
                          )));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
