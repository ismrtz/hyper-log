// packages
import 'package:flutter/material.dart';

// widgets
import 'package:hyper_log/widgets/home/expense_account.dart';

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
        color: const Color.fromRGBO(7, 19, 17, 1),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ExpenseAccount(balance),
                IconButton(
                    onPressed: _notificationTap,
                    icon: const Icon(
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
