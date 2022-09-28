import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/admin';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // h1
              Text('จัดการข้อมูล', style: TextStyle(fontSize: 20)),
              // manage post button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin/managePost');
                },
                child: const Text('จัดการประชาสัมพันธ์'),
              ),
              // manage user button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin/manage-users');
                },
                child: const Text('จัดการผู้ใช้'),
              ),
              // align bottom
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.clear();
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('ออกจากระบบ'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
