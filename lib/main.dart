//packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//screens
import './screens/dashboard.dart';
import './screens/new_transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'VazirMatn',
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: Dashboard()),
      routes: {
        NewTransaction.routeName: (context) => const NewTransaction(),
      },
    );
  }
}
