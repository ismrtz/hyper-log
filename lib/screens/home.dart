import 'package:flutter/material.dart';

import '../widgets/home/expense-account.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final int balance = 50000;

  void _notificationTap() {
    print('notification taped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(7, 19, 17, 1),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ExpenseAccount(balance),
                IconButton(
                    onPressed: _notificationTap,
                    icon: Icon(
                      size: 32,
                      color: Colors.grey,
                      Icons.notifications_active_outlined,
                    )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
