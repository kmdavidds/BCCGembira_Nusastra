import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nusastra/models/token.dart';

class ApiService {
  static const String baseUrl =
      'https://2699-202-93-245-215.ngrok-free.app/api/v1'; // Replace with your API endpoint

  static String parseError(Map<String, dynamic> json) {
    return switch (json) {
      {
        "message": String err,
      } =>
        err,
      _ => "unknown",
    };
  }

  static Future<Token> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw ErrorDescription(
          parseError(jsonDecode(response.body) as Map<String, dynamic>));
    }

    return Token.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<String> register(
      String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/users/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'display_name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw HttpException('Failed to register: ${response.body}');
    }

    return "Success";
  }

  static Future<String> saveAndUploadImage(File file) async {
    // Save the image to a local directory
    final directory = await Directory.systemTemp.createTemp();
    final localFile = File('${directory.path}/${file.path.split('/').last}');
    await localFile.writeAsBytes(await file.readAsBytes());

    // Upload the saved image using Dio
    final dio = Dio();
    String url = ('$baseUrl/chats/create-chat-ocr');
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        localFile.path,
        filename: localFile.path.split('/').last,
      ),
    });

    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjE0ZWE3YWMtMmMyMy00MzhkLWE4NzMtZGEyNTY2ZThlOTQyIiwidXNlcm5hbWUiOiJyb2JpbjEyMzQiLCJleHAiOjE3NDU2NzczNjh9.lsG0Wym9bhdZYjcsCqA7FXULma90VKqzGTERdd9piq0';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    final response = await dio.post(url, data: formData);

    // Clean up the temporary file
    await localFile.delete();

    return response.toString();
  }

  static Future<String> uploadImage(String base64) async {
    // Upload the saved image using Dio
    final dio = Dio();
    String url = ('$baseUrl/chats/create-chat-ocr');
    final formData = FormData.fromMap({
      'base64': base64
    });

    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjE0ZWE3YWMtMmMyMy00MzhkLWE4NzMtZGEyNTY2ZThlOTQyIiwidXNlcm5hbWUiOiJyb2JpbjEyMzQiLCJleHAiOjE3NDU2NzczNjh9.lsG0Wym9bhdZYjcsCqA7FXULma90VKqzGTERdd9piq0';

    final response = await dio.post(url, data: formData);

    return response.toString();
  }

//   static Future<List<Classroom>> getClassrooms(String auth) async {
//     final url = Uri.parse('$baseUrl/api/classrooms');
//     final response = await http.get(
//       url,
//       headers: {HttpHeaders.authorizationHeader: 'Bearer $auth'},
//     );

//     if (response.statusCode != 200) {
//       throw HttpException('Failed to get classrooms: ${response.statusCode}');
//     }

//     var classrooms = <Classroom>[];
//     final Map<String, dynamic> json =
//         jsonDecode(response.body) as Map<String, dynamic>;
//     if (json['data'] != null) {
//       json['data'].forEach((v) {
//         classrooms.add(Classroom.fromJson(v));
//       });
//     }

//     return classrooms;
//   }
}
