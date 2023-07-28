//packages
import 'package:flutter/material.dart';

//data
import 'package:hyper_log/data/icon_list.dart';
import 'package:hyper_log/data/color_list.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({required this.selectIcon, super.key});

  @override
  State<IconPicker> createState() => _IconPickerState();

  final Function selectIcon;
}

class _IconPickerState extends State<IconPicker> {
  String icon = '0xe25c';
  String color = '0xFF90A4AE';

  void selectColor(String selectedColor) {
    setState(() {
      color = selectedColor;
    });
  }

  void onSelectIcon(String selectedIcon) {
    setState(() {
      icon = selectedIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  customBorder: BeveledRectangleBorder(
                      side: BorderSide(
                        width: 6,
                        color: colorList[index] == color
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(56)),
                  onTap: () => selectColor(colorList[index]),
                  borderRadius: BorderRadius.circular(56),
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 6,
                            color: colorList[index] == color
                                ? Colors.white
                                : Colors.transparent),
                        color: Color(int.parse(colorList[index])),
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                itemCount: colorList.length,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 200,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 40,
                ),
                itemCount: iconList.length,
                itemBuilder: (context, index) => InkWell(
                  customBorder: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(56)),
                  onTap: () => onSelectIcon(iconList[index]),
                  borderRadius: BorderRadius.circular(56),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: iconList[index] == icon
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        color: Color(int.parse(color)),
                        borderRadius: BorderRadius.circular(48)),
                    child: Icon(
                      IconData(int.parse(iconList[index]),
                          fontFamily: 'MaterialIcons'),
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.selectIcon(icon, color);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
                textStyle: const MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                    fontFamily: 'VazirMatn',
                    fontWeight: FontWeight.bold)),
                minimumSize:
                    const MaterialStatePropertyAll(Size.fromHeight(56)),
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(40, 204, 158, 1)),
              ),
              child: const Text('تایید'),
            )
          ],
        ));
  }
}
