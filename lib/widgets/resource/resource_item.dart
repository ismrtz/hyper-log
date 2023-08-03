// models
import '../../models/resource.dart';

// packages
import 'package:flutter/material.dart';

class ResourceItem extends StatelessWidget {
  const ResourceItem(
      {required this.resource, required this.selectResource, super.key});

  final Resource resource;
  final Function selectResource;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          selectResource(resource);
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
            backgroundColor: Color(int.parse(resource.color)),
            child: Icon(
              IconData(int.parse(resource.icon), fontFamily: 'MaterialIcons'),
              color: Colors.white,
            )),
        title: Text(
          resource.title,
          style:
              TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
