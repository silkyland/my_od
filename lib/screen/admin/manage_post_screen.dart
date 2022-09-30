import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagePostScreen extends StatefulWidget {
  static const routeName = '/admin/managePost';
  const ManagePostScreen({super.key});

  @override
  State<ManagePostScreen> createState() => _ManagePostScreenState();
}

class _ManagePostScreenState extends State<ManagePostScreen> {
  var posts = [];

  Future<void> _getPosts() async {
    var conn = await Connection.getConnection();
    var result = await conn.query(
        'SELECT posts.post_id, posts.title, posts.content, posts.created_at, users.name FROM posts INNER JOIN users ON posts.user_id = users.user_id');

    var data = [];
    for (var row in result) {
      data.add(row.fields);
    }

    print(data);

    setState(() {
      posts = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการประชาสัมพันธ์'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('จัดการประชาสัมพันธ์', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              // list
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(posts[index]['title']),
                      subtitle: Text(posts[index]['content'].toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          // dialog
                          var result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('ยืนยันการลบ'),
                                content:
                                    Text('คุณต้องการลบข้อมูลนี้ใช่หรือไม่'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text('ยกเลิก'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context, true);
                                      var conn =
                                          await Connection.getConnection();
                                      await conn.query(
                                          'DELETE FROM posts WHERE post_id = ?',
                                          [posts[index]['post_id']]);
                                      _getPosts();
                                    },
                                    child: Text('ยืนยัน'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/admin/createPost');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
