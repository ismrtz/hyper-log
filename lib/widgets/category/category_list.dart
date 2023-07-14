// models
import '../../models/category.dart';

// packages
import 'package:flutter/material.dart';

// widgets
import './category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList(
      {required this.categories, required this.selectCategory, super.key});

  final Function selectCategory;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 360,
        child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: categories.length,
            itemBuilder: (context, index) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      CategoryCard(
                        category: categories[index],
                        selectCategory: selectCategory,
                      )
                    ],
                  ),
                )));
  }
}
