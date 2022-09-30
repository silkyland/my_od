import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_od/connection.dart';
import 'package:my_od/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/admin/createPost';
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var hasError = false;
  var errorMessage = '';

  Future<void> _createPost() async {
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    var conn = await Connection.getConnection();
    var result = await conn.query(
        'INSERT INTO posts (title, content, user_id) VALUES (?, ?, ?)',
        [titleController.text, contentController.text, userId]);
    if (result.affectedRows! > 0) {
      Navigator.pushReplacementNamed(context, '/admin/managePost');
    } else {
      setState(() {
        hasError = true;
        errorMessage = 'Cannot create post';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    var role = prefs.getString('role');
    if (userId == null || role != 'admin') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สร้างประชาสัมพันธ์'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('สร้างประชาสัมพันธ์', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: titleController,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                controller: contentController,
              ),
              SizedBox(height: 20),
              // submit button
              ElevatedButton(
                onPressed: _createPost,
                child: const Text('สร้าง'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
