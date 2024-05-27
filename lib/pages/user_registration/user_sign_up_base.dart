import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserSignUpBase {
  const UserSignUpBase();

  Future<bool> isUserExist(BuildContext context, String email) async {
    const url = 'http://localhost:5074/api/User';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> _users = jsonResponse;

        for (var user in _users) {
          if (user is Map) {
            String? userEmail = user['userEmail'];

            if (userEmail == email) {
              return true;
            }
          }
        }
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check user existence: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      );
      return false;
    }
  }
}
