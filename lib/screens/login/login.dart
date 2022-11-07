import 'dart:ui';

import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late IO.Socket socket;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController username = TextEditingController();
  final TextEditingController room = TextEditingController();

  @override
  void initState() {
    initSocket();

    super.initState();
  }

  initSocket() {
    try {
      socket = IO.io(socketUri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      print('trying connnection');
      socket.connect();

      socket.onConnect((data) {
        print('Connect: ${socket.id}');
      });
    } catch (e) {
      print('error');
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: double.infinity,
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        LoadingAnimationWidget.bouncingBall(
                          // leftDotColor: Colors.deepPurple,
                          // rightDotColor: const Color(0xFFEA3799),
                          color: Colors.deepPurple,
                          size: 95,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Join a room',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.deepPurple[500],
                                  ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: username,
                          validator: ((value) {
                            if (value!.isEmpty) return '* Required';
                            if (value.length < 3) {
                              return 'must contain more than 3 characters';
                            }
                            return null;
                          }),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple.shade700),
                            ),
                            label: const Text('username'),
                            labelStyle: const TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                            hintText: 'johnkoder.dev',
                            hintStyle: TextStyle(color: Colors.deepPurple[300]),
                          ),
                          style: TextStyle(color: Colors.deepPurple[500]),
                          cursorColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: room,
                          validator: ((value) {
                            if (value!.isEmpty) return '* Required';
                            return null;
                          }),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple.shade700),
                            ),
                            label: const Text('room'),
                            labelStyle: const TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                            hintText: 'eg. koder hub',
                            hintStyle: TextStyle(color: Colors.deepPurple[300]),
                          ),
                          style: TextStyle(color: Colors.deepPurple[500]),
                          cursorColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                // next step
                                next();
                              }
                            },
                            child: const Text('Join')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  next() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black26,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Center(
              child: LoadingAnimationWidget.discreteCircle(
                // leftDotColor: Colors.deepPurple,
                // rightDotColor: const Color(0xFFEA3799),
                color: Colors.deepPurple,
                size: 130,
              ),
            ),
          );
        });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();

      socket.emit('join', {'room': room.text, 'username': username.text});
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }
}
