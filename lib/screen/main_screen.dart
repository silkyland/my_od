import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/screen/home_screen.dart';
import 'package:my_od/screen/profile_screen.dart';
import 'package:my_od/screen/webboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> tabs = [
    {
      "icon": Icons.home,
      "title": "หน้าหลัก",
      "screen": HomeScreen(),
    },
    {
      "icon": Icons.chat,
      "title": "สนทนา",
      "screen": WebboardScreen(),
    },
    {
      "icon": Icons.person,
      "title": "ข้อมูลส่วนตัว",
      "screen": ProfileScreen(),
    },
  ];

  int _selectedIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabs[_selectedIndex]["title"]),
      ),
      body: tabs[_selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        items: tabs
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e["icon"]),
                label: e["title"],
              ),
            )
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _changeTab,
      ),
    );
  }
}
