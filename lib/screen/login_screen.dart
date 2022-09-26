import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  var hasError = false;
  var errorMessage = '';

// function doLogin
  Future<void> _doLogin() async {
    var conn = await Connection.getConnection();
    var result = await conn.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [_usernameController.text, _passwordController.text]);
    print(result);
    if (result.length > 0) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        hasError = true;
        errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เข้าสู่ระบบ'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'เข้าสู่ระบบ',
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
                : Container(
                    height: 10,
                  ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _doLogin,
                      child: Text('เข้าสู่ระบบ'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('สมัครสมาชิก'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
