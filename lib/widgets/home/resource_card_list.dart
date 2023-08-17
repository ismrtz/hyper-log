// packages
import 'package:flutter/material.dart';
import 'package:hyper_log/widgets/resource/resource_card.dart';

class ResourceCardList extends StatefulWidget {
  const ResourceCardList({required this.resources, super.key});

  final List<Map> resources;

  @override
  State<ResourceCardList> createState() => _ResourceCardListState();
}

class _ResourceCardListState extends State<ResourceCardList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.insert_chart_outlined,
              color: Color.fromRGBO(40, 204, 158, 1),
            ),
            SizedBox(width: 4),
            Text(
              'منابع مالی',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 191,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.resources.length,
              itemBuilder: (context, index) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        ResourceCard(
                          width: 270,
                          resource: widget.resources[index],
                          selectResource: () {},
                          margin: const EdgeInsets.only(left: 16),
                        )
                      ],
                    ),
                  )),
        ),
      ],
    );
  }
}
