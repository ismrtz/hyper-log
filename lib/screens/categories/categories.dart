import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  static const routeName = '/categories';

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        padding: const EdgeInsets.all(24),
        child: const SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: []),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
