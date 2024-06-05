import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePageBase {
  Future<List<Map<String, dynamic>>> getUserById(String id) async {
    final url =
        Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

    try {
      final response = await http
          .get(Uri.parse('$url/api/User/GetAuthorById/$id'), headers: {
        'Accept': 'application/json',
        'Accept-Charset': 'utf-8',
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Map<String, dynamic>> users = [];

        for (var user in jsonResponse) {
          if (user is Map) {
            int? id = user['authorID'];
            String? name = user['userName'];
            String? surname = user['userSurname'];
            String? email = user['userEmail'];
            String? roleName = user['roleName'];
            String? statusName = user['statusName'];
            String? bio = user['authorBio'];
            String? imageUrl = user['userPPUrl'];

            users.add({
              'id': id,
              'name': name,
              'surname': surname,
              'email': email,
              'role': roleName,
              'status': statusName,
              'bio': bio,
              'imageUrl': imageUrl,
            });
          }
        }

        return users;
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
