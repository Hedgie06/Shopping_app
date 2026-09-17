import 'package:flutter/material.dart';
import 'views/product_list_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Reenable network connectivity listener after resolving emulator connectivity detection issue
  //NetworkService.listen(navigatorKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProductListScreen(),
    );
  }
}