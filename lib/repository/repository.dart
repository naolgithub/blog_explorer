import 'dart:convert';
import 'dart:developer';

import 'package:blog_explorer/model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqlite_api.dart';

class BlogRepository {
  late final Database database;
  final String tableName = 'blogs';

  Future<List<BlogModel>> getBlogs() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'x-hasura-admin-secret': adminSecret,
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response data here
      final List result = jsonDecode(response.body)['blogs'];
      return result.map((e) => BlogModel.fromJson(e)).toList();
    } else {
      // Request failed
      log('Request failed with status code: ${response.statusCode}');
      log('Response data: ${response.body}');
      throw Exception(response.reasonPhrase);
    }
  }
}
