import 'dart:convert';

// import 'package:flutter_api/constants.dart';
import 'package:flutter_api/models/users_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<User>> getPosts() async {
    Response res = await get(Uri.parse(postsUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw 'Unable to retrieve Posts';
    }
  }
}




// class ApiService {
//   Future<List<UserModel>?> getUsers() async {
//     try{
//       var Url = Uri.parse(ApiConstants.baseURL + ApiConstants.userEndpoint);
//       var response = awaits http.get(url);
//       if(response.statusCode == 200) {
//         List<UserModel> _model = userModelFromJson(response.body);
//         return _model;
//       }
//     }
//     catch (e) {
//       log(e.toString());
//     }
//   }
// }