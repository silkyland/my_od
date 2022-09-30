import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_od/connection.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var post = {};

  @override
  void initState() {
    super.initState();
    print(widget.postId);
    _getPostById();
  }

  void _getPostById() async {
    var conn = await Connection.getConnection();
    var results = await conn.query(
      """
        SELECT posts.post_id, posts.title, posts.content, posts.created_at, users.name FROM posts INNER JOIN users ON posts.user_id = users.user_id WHERE posts.post_id = ?
      """,
      [widget.postId],
    );
    print(results);

    var data = {};
    for (var row in results) {
      print(row.fields);
      data = row.fields;
    }
    setState(() {
      post = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happ OLD'),
      ),
      body: post.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : Container(
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          post['name'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          post['content'].toString(),
                          style: TextStyle(
                            fontSize: 15,
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
