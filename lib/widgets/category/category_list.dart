// models
import '../../models/category.dart';

// packages
import 'package:flutter/material.dart';

// widgets
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList(
      {required this.height,
      required this.categories,
      required this.selectCategory,
      super.key});

  final double height;
  final Function selectCategory;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: categories.length,
            itemBuilder: (context, index) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      CategoryItem(
                        category: categories[index],
                        selectCategory: selectCategory,
                      )
                    ],
                  ),
                )));
  }
}
