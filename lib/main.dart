// providers
import './providers/account.dart';

//packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//screens
import './screens/dashboard.dart';
import './screens/resources/resources.dart';
import './screens/categories/categories.dart';
import './screens/resources/new_resource.dart';
import './screens/categories/new_category.dart';
import 'screens/transactions/new_transaction.dart';

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
    return ChangeNotifierProvider(
      create: (BuildContext context) => Account(),
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'VazirMatn',
            bottomSheetTheme:
                const BottomSheetThemeData(dragHandleColor: Colors.grey)),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: Dashboard()),
        routes: {
          NewTransaction.routeName: (context) => const NewTransaction(),
          Resources.routeName: (context) => const Resources(),
          Categories.routeName: (context) => const Categories(),
          NewResource.routeName: (context) => const NewResource(),
          NewCategory.routeName: (context) => const NewCategory(),
        },
      ),
    );
  }
}
