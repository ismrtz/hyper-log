import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  static const routeName = '/new-transaction';

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController(text: '0');

  List<bool> isCardEnabled = [];

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
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(25, 107, 105, 1))),
                          suffixText: 'تومان',
                          prefixText: 'مبلغ:',
                          prefixStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          suffixStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        autofocus: true,
                        controller: _amountController,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(19, 47, 43, 1))),
                        onPressed: () {},
                        icon: Icon(Icons.arrow_outward),
                        label: Text('پرداختی'))),
              ],
            )
          ]),
        ),
      ),
    );
    ;
  }
}
