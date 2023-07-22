// packages
import 'package:flutter/material.dart';

// widgets
import './bank_resource_list.dart';
import './cash_resource_list.dart';

class NewResource extends StatefulWidget {
  const NewResource({super.key});

  static const routeName = '/resources/new';

  @override
  State<NewResource> createState() => _NewResourceState();
}

class _NewResourceState extends State<NewResource> {
  bool isBank = true;

  final _formKey = GlobalKey<FormState>();
  final _resourceTitleController = TextEditingController();
  final _amountController = TextEditingController(text: '0');
  final _cardNumberController = TextEditingController(text: '-');
  final _accountNumberController = TextEditingController(text: '-');
  Map selectedResource = {
    'title': 'نام منبع خرج',
    'icon': '0xee33',
  };

  Map selectedIcon = {
    'icon': '0xee33',
  };

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setBankType() {
    setState(() {
      isBank = true;
    });
  }

  void _setCashType() {
    setState(() {
      isBank = false;
    });
  }

  void _tapResourceBank(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        backgroundColor: const Color.fromRGBO(12, 29, 27, 1),
        context: context,
        builder: (_) {
          return GestureDetector(
              child: BankResourceList(selectResource: selectResource));
        });
  }

  void _tapResourceIcon(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        backgroundColor: const Color.fromRGBO(12, 29, 27, 1),
        context: context,
        builder: (_) {
          return GestureDetector(
              child: CashResourceList(selectIcon: selectIcon));
        });
  }

  void selectResource(resource) {
    setState(() {
      selectedResource = resource;
    });
  }

  void selectIcon(icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'منبع خرج جدید',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () => _closeScreen(context),
                          icon: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.grey[200],
                            size: 32,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  height: MediaQuery.of(context).size.height - 146,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(12, 29, 27, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 32),
                            child: TextButton.icon(
                                style: ButtonStyle(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 14)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    backgroundColor: MaterialStatePropertyAll(
                                        isBank
                                            ? const Color.fromRGBO(
                                                19, 47, 43, 1)
                                            : Colors.transparent)),
                                onPressed: _setBankType,
                                icon: Icon(
                                  Icons.credit_card,
                                  color: isBank
                                      ? const Color.fromRGBO(40, 204, 158, 1)
                                      : const Color.fromRGBO(
                                          40, 204, 158, 0.48),
                                ),
                                label: Text(
                                  'بانک',
                                  style: TextStyle(
                                      color: isBank
                                          ? Colors.white
                                          : Colors.white54),
                                )),
                          ),
                          TextButton.icon(
                              style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 14)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  backgroundColor: MaterialStatePropertyAll(
                                      !isBank
                                          ? const Color.fromRGBO(19, 47, 43, 1)
                                          : Colors.transparent)),
                              onPressed: _setCashType,
                              icon: Icon(
                                Icons.payments_outlined,
                                color: !isBank
                                    ? const Color.fromRGBO(255, 51, 102, 1)
                                    : const Color.fromRGBO(255, 51, 102, 0.48),
                              ),
                              label: Text(
                                'نقد',
                                style: TextStyle(
                                    color: !isBank
                                        ? Colors.white
                                        : Colors.white54),
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: isBank
                            ? Form(
                                //TODO: add form validation
                                key: _formKey,
                                child: Column(children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor:
                                          const Color.fromRGBO(15, 36, 34, 1),
                                      onTap: () => _tapResourceBank(context),
                                      child: Row(children: [
                                        Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                color:
                                                    selectedResource['color'] !=
                                                            null
                                                        ? Color(int.parse(
                                                            selectedResource[
                                                                'color']))
                                                        : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            child: Icon(
                                              IconData(
                                                  int.parse(
                                                      selectedResource['icon']),
                                                  fontFamily: 'MaterialIcons'),
                                              size: 32,
                                              color:
                                                  selectedResource['color'] !=
                                                          null
                                                      ? Colors.white
                                                      : Colors.white54,
                                            )),
                                        Text(
                                          selectedResource['title'],
                                          style: TextStyle(
                                              color:
                                                  selectedResource['color'] !=
                                                          null
                                                      ? Colors.white
                                                      : Colors.white54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[800],
                                  ),
                                  TextFormField(
                                    validator: (value) => value == null ||
                                            value.isEmpty ||
                                            value == '0'
                                        ? 'موجودی نمی‌تواند خالی باشد'
                                        : null,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      suffixText: 'تومان',
                                      prefixText: 'موجودی:',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      suffixStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(40, 204, 158, 1),
                                          fontSize: 16,
                                          wordSpacing: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Color.fromRGBO(40, 204, 158, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _amountController,
                                    textAlign: TextAlign.left,
                                  ),
                                  Divider(
                                    color: Colors.grey[800],
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      prefixText: 'شماره کارت:',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white54,
                                    ),
                                    controller: _cardNumberController,
                                    textAlign: TextAlign.left,
                                  ),
                                  Divider(
                                    color: Colors.grey[800],
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      prefixText: 'شماره حساب:',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white54,
                                    ),
                                    controller: _accountNumberController,
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                              )
                            : Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(56),
                                            border: Border.all(
                                                width: 2,
                                                color: selectedIcon['color'] !=
                                                        null
                                                    ? Color(int.parse(
                                                        selectedIcon['color']))
                                                    : Colors.transparent)),
                                        child: IconButton(
                                          onPressed: () =>
                                              _tapResourceIcon(context),
                                          icon: Icon(
                                            IconData(
                                                int.parse(selectedIcon['icon']),
                                                fontFamily: 'MaterialIcons'),
                                            size: 28,
                                            color: selectedIcon['color'] != null
                                                ? Color(int.parse(
                                                    selectedIcon['color']))
                                                : Colors.white54,
                                          ),
                                        ),
                                      ),
                                      hintStyle: const TextStyle(
                                          color: Colors.white54),
                                      hintText: 'نام منبع خرج',
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    autofocus: true,
                                    controller: _resourceTitleController,
                                    textAlign: TextAlign.right,
                                  ),
                                  Divider(
                                    color: Colors.grey[800],
                                  ),
                                  TextFormField(
                                    validator: (value) => value == null ||
                                            value.isEmpty ||
                                            value == '0'
                                        ? 'موجودی نمی‌تواند خالی باشد'
                                        : null,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      suffixText: 'تومان',
                                      prefixText: 'موجودی:',
                                      prefixStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      suffixStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(40, 204, 158, 1),
                                          fontSize: 16,
                                          wordSpacing: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Color.fromRGBO(40, 204, 158, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _amountController,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(40, 204, 158, 1),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print('sending data');
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}