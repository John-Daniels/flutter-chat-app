import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/login/login.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> get routes => [
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
      ];
}
