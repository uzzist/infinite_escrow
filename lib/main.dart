import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/themes/dark_theme.dart';
import 'package:infinite_escrow/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Infinite Escrow',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SplashScreen(),
    );
  }
}