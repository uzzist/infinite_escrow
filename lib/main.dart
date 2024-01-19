import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:infinite_escrow/routes/routes.dart';

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
      theme: ThemeData(
        fontFamily: FontConstant.jakartaRegular,
      ),
      home: SplashScreen(),
    );
  }
}