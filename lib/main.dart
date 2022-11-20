import 'package:chat_app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Chat app",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const LoginScreen(),
    );
  }


}
