// packages
import 'package:flutter/material.dart';

// utils
import 'package:hyper_log/utils/amount.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard(
      {required this.resource, required this.selectResource, super.key});

  final Map resource;
  final Function selectResource;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(resource['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70.withOpacity(0.80),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Text(
                                Amount.toSeparator(resource['amount'].abs()),
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                resource['amount'] > 0
                                    ? Icons.add
                                    : Icons.remove,
                                color: resource['amount'] > 0
                                    ? const Color.fromRGBO(40, 204, 158, 1)
                                    : const Color.fromRGBO(255, 51, 102, 1),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
