// models
import '../../models/resource.dart';

// packages
import 'package:flutter/material.dart';

// widgets
import 'resource_item.dart';

class ResourceList extends StatelessWidget {
  const ResourceList(
      {required this.height,
      required this.field,
      required this.resources,
      required this.selectResource,
      super.key});

  final String field;
  final double height;
  final Function selectResource;
  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: resources.length,
            itemBuilder: (context, index) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      ResourceItem(
                        field: field,
                        resource: resources[index],
                        selectResource: selectResource,
                      )
                    ],
                  ),
                )));
  }
}
