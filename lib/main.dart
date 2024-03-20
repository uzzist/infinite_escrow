import 'package:get_storage/get_storage.dart';
import 'package:infinite_escrow/routes/routes.dart';
import 'package:infinite_escrow/screens/appAppearance/controller/theme_controller.dart';
import 'package:infinite_escrow/themes/dark_theme.dart';
import 'package:infinite_escrow/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Infinite Escrow',
      debugShowCheckedModeBanner: false,
      theme: _themeController.darkMode.value ? darkTheme : lightTheme,
      home: SplashScreen(),
    );
  }
}