// packages
import 'package:flutter/material.dart';

// models
import 'package:hyper_log/models/category.dart';

// widgets
import 'package:hyper_log/widgets/global/icon_picker.dart';

// services
import 'package:hyper_log/services/categories_sqlite_service.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  static const routeName = '/categories/new';

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  bool isReceipt = true;

  Map selectedIcon = {
    'icon': '0xf0d7',
  };

  final _formKey = GlobalKey<FormState>();
  final _categoryTitleController = TextEditingController();

  late CategoriesSqliteService _categoriesSqliteService;

  @override
  void initState() {
    super.initState();

    _categoriesSqliteService = CategoriesSqliteService();
  }

  void _backScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setReceiptType() {
    setState(() {
      isReceipt = true;
    });
  }

  void _setPaymentType() {
    setState(() {
      isReceipt = false;
    });
  }

  void _tapCategoryIcon(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        backgroundColor: const Color.fromRGBO(12, 29, 27, 1),
        context: context,
        builder: (_) {
          return GestureDetector(
              child: IconPicker(
            selectIcon: selectIcon,
          ));
        });
  }

  void selectIcon(String icon, String color) {
    setState(() {
      selectedIcon['icon'] = icon;
      selectedIcon['color'] = color;
    });
  }

  Future<void> addNewCategory() async {
    if (_formKey.currentState!.validate() && selectedIcon['color'] != null) {
      final cashResource = Category(
          title: _categoryTitleController.text,
          type: isReceipt ? 1 : 0,
          icon: selectedIcon['icon'],
          color: selectedIcon['color']);

      return await _categoriesSqliteService.initializeDB().whenComplete(() =>
          _categoriesSqliteService
              .insertCategory(cashResource)
              .whenComplete(() {
            showSuccessfulMessage();
            Navigator.of(context).pop();
          }));
    }
  }

  void showSuccessfulMessage() {
    const snackBar = SnackBar(content: Text('✅ دسته‌بندی با موفقیت ساخته شد'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        'دسته‌بندی جدید',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () => _backScreen(context),
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
                                        isReceipt
                                            ? const Color.fromRGBO(
                                                19, 47, 43, 1)
                                            : Colors.transparent)),
                                onPressed: _setReceiptType,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: isReceipt
                                      ? const Color.fromRGBO(40, 204, 158, 1)
                                      : const Color.fromRGBO(
                                          40, 204, 158, 0.48),
                                ),
                                label: Text(
                                  'دریافتی',
                                  style: TextStyle(
                                      color: isReceipt
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
                                      !isReceipt
                                          ? const Color.fromRGBO(19, 47, 43, 1)
                                          : Colors.transparent)),
                              onPressed: _setPaymentType,
                              icon: Icon(
                                Icons.arrow_outward,
                                color: !isReceipt
                                    ? const Color.fromRGBO(255, 51, 102, 1)
                                    : const Color.fromRGBO(255, 51, 102, 0.48),
                              ),
                              label: Text(
                                'پرداختی',
                                style: TextStyle(
                                    color: !isReceipt
                                        ? Colors.white
                                        : Colors.white54),
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لطفا نامی برای دسته‌بندی درج کنید';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.only(left: 12),
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: selectedIcon['color'] != null
                                          ? Color(
                                              int.parse(selectedIcon['color']))
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: IconButton(
                                      onPressed: () =>
                                          _tapCategoryIcon(context),
                                      icon: Icon(
                                        IconData(
                                            int.parse(selectedIcon['icon']),
                                            fontFamily: 'MaterialIcons'),
                                        size: 28,
                                        color: selectedIcon['color'] != null
                                            ? Colors.white
                                            : Colors.white54,
                                      ),
                                    ),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white54),
                                  hintText: 'نام دسته‌بندی',
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                // autofocus: true,
                                controller: _categoryTitleController,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Divider(
                              color: Colors.grey[800],
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
        onPressed: addNewCategory,
        child: const Icon(Icons.done),
      ),
    );
  }
}
