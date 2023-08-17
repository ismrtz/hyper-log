import 'package:flutter/material.dart';

class Toast {
  static Widget setIcon(String iconType) {
    switch (iconType) {
      case 'success':
        return const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.done_rounded,
            color: Color.fromRGBO(40, 204, 158, 1),
          ),
        );
      case 'error':
        return const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.dangerous_outlined,
            color: Color.fromRGBO(255, 51, 102, 1),
          ),
        );
      default:
        return const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.info_outline_rounded,
            color: Color.fromRGBO(51, 187, 255, 1),
          ),
        );
    }
  }

  static SnackBar createToast(String text, String iconType) {
    return SnackBar(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(children: [
          setIcon(iconType),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'VazirMatn',
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
