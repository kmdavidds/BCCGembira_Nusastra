import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nusastra/models/token.dart';

class ApiService {
  static const String baseUrl =
      'https://b7e9-202-93-245-215.ngrok-free.app/api/v1'; // Replace with your API endpoint

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

  static Future<String> uploadImage(filename) async {
    String url = "https://api.ocr.space/parse/image";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.statusCode.toString();
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
