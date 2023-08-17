// packages
import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips(
      {required this.title,
      required this.actionTitle,
      required this.acitonCallback,
      super.key});

  final String title;
  final String actionTitle;
  final VoidCallback acitonCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(12, 29, 27, 1),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color.fromRGBO(25, 107, 105, 0.32),
            ),
            child: const Icon(
              Icons.tips_and_updates_outlined,
              color: Color.fromRGBO(255, 199, 0, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton.icon(
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(40, 204, 158, 1))),
              onPressed: acitonCallback,
              icon: const Icon(
                Icons.add,
                color: Color.fromRGBO(19, 47, 43, 1),
              ),
              label: Text(
                actionTitle,
                style: const TextStyle(
                    color: Color.fromRGBO(19, 47, 43, 1), fontSize: 16),
              )),
        ],
      ),
    );
  }
}
