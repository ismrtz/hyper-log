// packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// widgets
import 'package:hyper_log/widgets/home/expense_account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int balance = 50000;

  void _exitApp() {
    SystemNavigator.pop();
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
                    onPressed: _exitApp,
                    icon: const Icon(
                      size: 32,
                      color: Colors.grey,
                      Icons.logout_outlined,
                    )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
