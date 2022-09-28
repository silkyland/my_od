import 'dart:io';

import 'package:mysql1/mysql1.dart';

var mysqlSettings = new ConnectionSettings(
  host: Platform.isIOS ? 'localhost' : '10.0.2.2',
  port: 3306,
  user: 'root',
  password: '1234',
  db: 'my_od',
);

class Connection {
  static Future<MySqlConnection> getConnection() async {
    var conn = await MySqlConnection.connect(mysqlSettings);
    return conn;
  }

  Connection() {
    _init();
  }

  void _init() async {
    var conn = await getConnection();
    var result = await conn.query('CREATE TABLE IF NOT EXISTS users ('
        'user_id INT NOT NULL AUTO_INCREMENT,'
        'username VARCHAR(255) NOT NULL UNIQUE,'
        'name VARCHAR(255) NOT NULL,'
        'email VARCHAR(255) NOT NULL,'
        'role VARCHAR(255) NOT NULL DEFAULT "user",'
        'password VARCHAR(255) NOT NULL,'
        'created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,'
        'updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,'
        'PRIMARY KEY (user_id)'
        ')');

    var postResult = await conn.query('CREATE TABLE IF NOT EXISTS posts ('
        'id INT NOT NULL AUTO_INCREMENT,'
        'user_id INT NOT NULL,'
        'title VARCHAR(255) NOT NULL,'
        'content TEXT NOT NULL,'
        'created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,'
        'updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,'
        'PRIMARY KEY (id)'
        ')');

    print(result);
    print(postResult);
  }
}
