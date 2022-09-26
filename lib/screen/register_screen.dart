import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  var hasError = false;
  var errorMessage = '';

  Future<void> _doRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        hasError = true;
        errorMessage = 'Password not match';
      });
    } else {
      var conn = await Connection.getConnection();
      var result = await conn.query(
          'INSERT INTO users (name, email, password) VALUES (?, ?)',
          [_nameController.text, _passwordController.text]);
      print(result);
      if (result.affectedRows! > 0) {
        Navigator.pushNamed(context, '/login');
      } else {
        setState(() {
          hasError = true;
          errorMessage = 'Cannot register';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'สมัครสมาชิก',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // hasError
              hasError
                  ? Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : Container(),
              Text(
                'ชื่อ-สกุล',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _nameController,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'อีเมล',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: _emailController,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'รหัสผ่าน',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'ยืนยันรหัสผ่าน',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _doRegister,
                  child: Text('สมัครสมาชิก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
