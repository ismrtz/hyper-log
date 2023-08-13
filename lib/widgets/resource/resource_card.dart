// packages
import 'package:flutter/material.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard(
      {required this.resource,
      required this.selectResource,
      required this.margin,
      required this.width,
      super.key});

  final double width;
  final Map resource;
  final EdgeInsets margin;
  final Function selectResource;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.colorDodge,
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(int.parse(resource['color'])),
                Colors.transparent,
                Color(int.parse(resource['color']))
              ]),
          border: Border.all(width: 2, color: Colors.white24),
          borderRadius: BorderRadius.circular(16)),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: const Color.fromRGBO(25, 107, 105, 1),
            borderRadius: BorderRadius.circular(14),
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(resource['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            )),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(56)),
                          child: Icon(
                            IconData(int.parse(resource['icon']),
                                fontFamily: 'MaterialIcons'),
                            color: Color(int.parse(resource['color'])),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Text(
                            Amount.toSeparator(resource['amount'].abs()),
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          if (resource['amount'] != 0)
                            resource['amount'] > 0
                                ? const Icon(
                                    Icons.add,
                                    color: Color.fromRGBO(40, 204, 158, 1),
                                  )
                                : const Icon(
                                    Icons.remove,
                                    color: Color.fromRGBO(255, 51, 102, 1),
                                  )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (resource['account'] != null || resource['card'] != null)
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(resource['account'] ?? '',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12)),
                        Text(resource['card'] ?? '',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12)),
                      ]),
                )
            ]),
          )),
    );
  }
}
