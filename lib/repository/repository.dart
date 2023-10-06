// import 'dart:convert';

// import 'package:http/http.dart';
// import 'package:naolaa_blog_copying/model/user_model.dart';

// class UserRepository {
//   String userUrl = 'https://reqres.in/api/users?page=2';

//   Future<List<BlogModel>> getUsers() async {
//     Response response = await get(Uri.parse(userUrl));
//     if (response.statusCode == 200) {
//       final List result = jsonDecode(response.body)['data'];
//       return result.map((e) => BlogModel.fromJson(e)).toList();
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   }
// }
import 'dart:convert';

import 'package:blog_explorer/model/blog_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqlite_api.dart';

class BlogRepository {
  late final Database database;
  final String tableName = 'blogs';

  // //
  // Future<List<BlogModel>> _fetchBlogsFromAPI() async {
  //   const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  //   const String adminSecret =
  //       '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       'x-hasura-admin-secret': adminSecret,
  //     },
  //   );

  //   // if (response.statusCode == 200) {
  //   //   final List<dynamic> jsonData = json.decode(response.body);
  //   //   return jsonData
  //   //       .map((data) => BlogModel(
  //   //             id: data['id'],
  //   //             title: data['title'],
  //   //             imageUrl: data['image_url'],
  //   //           ))
  //   //       .toList();
  //   // } else {
  //   //   throw Exception('Failed to fetch blogs');
  //   // }

  //   if (response.statusCode == 200) {
  //     // Request successful, handle the response data here
  //     final List result = jsonDecode(response.body)['blogs'];
  //     return result.map((e) => BlogModel.fromJson(e)).toList();
  //   } else {
  //     // Request failed
  //     // print('Request failed with status code: ${response.statusCode}');
  //     // print('Response data: ${response.body}');
  //     throw Exception(response.reasonPhrase);
  //   }
  // }
  ////////////

  ////////////
  // Future<void> _saveBlogsLocally(List<BlogModel> blogs) async {
  //   final batch = database.batch();
  //   for (final blog in blogs) {
  //     batch.insert(tableName, {
  //       'id': blog.id,
  //       'title': blog.title,
  //       'image_url': blog.imageUrl,
  //     });
  //   }
  //   await batch.commit();
  // }

  /////////
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
      ////////////////////
      // try {
      //   final List<Map<String, dynamic>> blogMaps =
      //       await database.query(tableName);
      //   if (blogMaps.isNotEmpty) {
      //     return blogMaps
      //         .map((blogMap) => BlogModel(
      //               id: blogMap['id'],
      //               title: blogMap['title'],
      //               imageUrl: blogMap['imageUrl'],
      //             ))
      //         .toList();
      //   } else {
      //     final List<BlogModel> onlineBlogs = await _fetchBlogsFromAPI();
      //     await _saveBlogsLocally(onlineBlogs);
      //     return onlineBlogs;
      //   }
      // } catch (e) {
      //   throw Exception('Failed to fetch blogs');
      // }

/////////////////////

      // Request successful, handle the response data here
      final List result = jsonDecode(response.body)['blogs'];
      return result.map((e) => BlogModel.fromJson(e)).toList();
    } else {
      // Request failed
      // print('Request failed with status code: ${response.statusCode}');
      // print('Response data: ${response.body}');
      throw Exception(response.reasonPhrase);
    }
  }
}
