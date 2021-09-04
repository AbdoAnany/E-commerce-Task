import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'control/products_notifier.dart';
import 'routes.dart';
import 'screen/sign_in/sign_in_screen.dart';
import 'theme.dart';

main() {
  // WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductsNotifier(),
      ),
      ChangeNotifierProvider(create: (_) => ProductsNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce Task',
      theme: theme(),
      home: SignInScreen(),
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
