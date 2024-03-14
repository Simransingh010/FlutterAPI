import 'dart:convert';

import 'package:flutter_api/models/users1_model.dart';
import 'package:http/http.dart';

class HttpUsers {
  final String usersUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<Users>> getUsers() async {
    Response res = await get(Uri.parse(usersUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Users> users = body
          .map(
            (dynamic item) => Users.fromJson(item),
          )
          .toList();
      return users;
    } else {
      throw "Unable to retrieve users.";
    }
  }
}
