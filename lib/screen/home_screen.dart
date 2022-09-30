import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';
import 'package:my_od/screen/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var posts = [];

  // isLogin
  var isLogin = false;
  var isAdmin = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _checkLogin();
  }

  void _checkLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var role = prefs.getString('role');

    if (user_id != null) {
      setState(() {
        isLogin = true;
      });
    }

    if (role == 'admin') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  void _fetchPosts() async {
    var conn = await Connection.getConnection();
    var results = await conn.query(
      """
          SELECT posts.post_id, posts.title, posts.content, posts.created_at, users.name FROM posts INNER JOIN users ON posts.user_id = users.user_id
      """,
    );
    print(results);
    var data = [];
    // loop through the results
    for (var row in results) {
      print(row.fields);
      data.add(row.fields);
    }
    setState(() {
      posts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  return Card(
                    child: ListTile(
                      onTap: () {
                        // ลิงค์ไปหน้า PostScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(
                              postId: posts[index]['post_id'].toString(),
                            ),
                          ),
                        );
                      },
                      title: Text(posts[index]['title']),
                      subtitle: Text(posts[index]['content'].toString()),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          !isLogin
              ? Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text('เข้าสู่ระบบ'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text('สมัครสมาชิก')),
                      ),
                    ],
                  ),
                )
              : isAdmin
                  ? Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/admin');
                              },
                              child: Text('จัดการข้อมูล'),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: Text('ข้อมูลส่วนตัว'),
                            ),
                          ),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}
