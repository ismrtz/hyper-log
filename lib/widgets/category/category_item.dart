// models
import '../../models/category.dart';

// packages
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {required this.category, required this.selectCategory, super.key});

  final Category category;
  final Function selectCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          selectCategory(category);
          Navigator.of(context).pop();
        },
        horizontalTitleGap: 12,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        tileColor: const Color.fromRGBO(255, 255, 255, 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
              width: 2, color: Color.fromRGBO(255, 255, 255, 0.24)),
        ),
        leading: CircleAvatar(
            backgroundColor: Color(int.parse(category.color)),
            child: Icon(
              IconData(int.parse(category.icon), fontFamily: 'MaterialIcons'),
              color: Colors.white,
            )),
        title: Text(
          category.title,
          style:
              TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
