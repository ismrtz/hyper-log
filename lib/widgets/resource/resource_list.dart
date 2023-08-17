// models
import '../../models/resource.dart';

// packages
import 'package:flutter/material.dart';

// widgets
import 'resource_item.dart';
import 'package:hyper_log/widgets/global/tips.dart';

// screens
import 'package:hyper_log/screens/resources/new_resource.dart';

class ResourceList extends StatelessWidget {
  const ResourceList(
      {required this.field,
      required this.height,
      required this.resources,
      required this.selectResource,
      super.key});

  final String field;
  final double height;
  final Function selectResource;
  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    return resources.isNotEmpty
        ? SizedBox(
            height: 360,
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
                    )))
        : Tips(
            title: 'منبع مالی برای ثبت تراکنش نداری! اضافه کن',
            actionTitle: 'منبع مالی جدید',
            acitonCallback: () =>
                Navigator.of(context).pushNamed(NewResource.routeName));
  }
}
