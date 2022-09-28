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
    var result = await conn.query('SELECT * FROM posts');

    for (var row in result) {
      posts.add(row.fields);
    }
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
              // h1
              Text('จัดการประชาสัมพันธ์', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              // table
              Container(
                width: double.infinity,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Content')),
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: posts
                      .map(
                        (post) => DataRow(
                          cells: [
                            DataCell(Text(post[0].toString())),
                            DataCell(Text(post[1])),
                            DataCell(Text(post[2])),
                            DataCell(Text(post[3].toString())),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
