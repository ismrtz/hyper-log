import 'package:flutter/material.dart';

class Tools extends StatefulWidget {
  const Tools({super.key});

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  final List<Map> tools = [
    {
      'locked': true,
      'title': 'بودجه‌بندی',
      'icon': Icons.ssid_chart_rounded,
      'color': const Color.fromRGBO(202, 157, 0, 1),
    },
    {
      'locked': true,
      'title': 'پس‌انداز',
      'icon': Icons.euro_rounded,
      'color': const Color.fromRGBO(82, 0, 255, 1),
    },
  ];

  // void showTipsModal() {
  //   final Widget tips = Container(
  //     height: 300,
  //     child: Column(
  //       children: [
  //         Text(
  //           'سلام',
  //           style: TextStyle(color: Colors.red),
  //         )
  //       ],
  //     ),
  //   );

  //   showModalBottomSheet(
  //       showDragHandle: true,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(24), topRight: Radius.circular(24))),
  //       backgroundColor: const Color.fromRGBO(12, 29, 27, 1),
  //       context: context,
  //       builder: (_) {
  //         return GestureDetector(child: tips);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromRGBO(7, 19, 17, 1),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ابزارها',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade200)),
                        const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.grey,
                            size: 32,
                          ),
                        ),
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.all(24),
                    height: MediaQuery.of(context).size.height - 206,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(12, 29, 27, 1),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tools
                          .map((tool) => Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 160, maxHeight: 112),
                                decoration: BoxDecoration(
                                    color: tool['color'],
                                    borderRadius: BorderRadius.circular(24)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor: Colors.black38,
                                    borderRadius: BorderRadius.circular(24),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                tool['title'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Text(
                                                  'بزودی',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Icon(
                                                  Icons.lock_outline,
                                                  color: Color.fromRGBO(
                                                      7, 19, 17, 1),
                                                ),
                                                Icon(
                                                  tool['icon'],
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ])
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
