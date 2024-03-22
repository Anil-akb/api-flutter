import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:api_demo/model/post.dart';

class ApiService {
  var url = 'https://jsonplaceholder.typicode.com/posts';
  Future<List<Post>?> getPost() async {
    var client = http.Client();

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    } else {
      if (kDebugMode) {
        print('Failed to load post: ${response.statusCode}');
      }
      return null;
    }
  }
}
