import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() async {
    var conn = await Connection.getConnection();
    var results =
        await conn.query('SELECT * FROM posts ORDER BY id DESC LIMIT 10');
    print(results);

    // loop through the results
    for (var row in results) {
      print('Post: ${row[0]}, ${row[1]}, ${row[2]}');
      //posts.add(row);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happ OLD'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ประชาสัมพันธ์',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('ประชาสัมพันธ์ $index'),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('เข้าสู่ระบบ'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('สมัครสมาชิก')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
