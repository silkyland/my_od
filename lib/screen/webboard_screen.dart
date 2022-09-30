import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WebboardScreen extends StatefulWidget {
  static const routeName = '/webboard';
  const WebboardScreen({super.key});

  @override
  State<WebboardScreen> createState() => _WebboardScreenState();
}

class _WebboardScreenState extends State<WebboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Webboard"),
      ),
    );
  }
}
