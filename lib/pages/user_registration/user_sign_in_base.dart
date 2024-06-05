import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserSignInBase {
  const UserSignInBase();

  Future<bool> login(String email, String password) async {
    final encodedEmail = Uri.encodeComponent(email);
    final encodedPassword = Uri.encodeComponent(password);
    final url =
        'http://localhost:5074/api/Auth/IsUserExist/$encodedEmail,%20$encodedPassword';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<dynamic> _users = jsonResponse;

        for (var user in _users) {
          if (user is Map) {
            int userId = user['authorID'];
            String? userEmail = user['userEmail'];
            String? userPassword = user['userPassword'];

            if (userEmail == email && userPassword == password) {
              await saveUserId(userId.toString());
              return true;
            }
          }
        }

        return false;
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<void> saveUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
      print("Kullanıcı ID'si kaydedildi: $userId");
    } catch (e) {
      print("Error: $e");
    }
  }
}
