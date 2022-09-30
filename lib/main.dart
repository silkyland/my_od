import 'package:flutter/material.dart';
import 'package:my_od/connection.dart';
import 'package:my_od/screen/admin/admin_screen.dart';
import 'package:my_od/screen/admin/create_post_screen.dart';
import 'package:my_od/screen/admin/manage_post_screen.dart';
import 'package:my_od/screen/home_screen.dart';
import 'package:my_od/screen/login_screen.dart';
import 'package:my_od/screen/main_screen.dart';
import 'package:my_od/screen/register_screen.dart';

void main() async {
  runApp(const MyApp());
  Connection();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/admin': (context) => const AdminScreen(),
        '/admin/managePost': (context) => const ManagePostScreen(),
        '/admin/createPost': (context) => const CreatePostScreen(),
      },
    );
  }
}
