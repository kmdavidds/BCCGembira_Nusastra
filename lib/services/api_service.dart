import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nusastra/models/token.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  static const String baseUrl =
      'https://87be-202-93-245-215.ngrok-free.app/api/v1'; // Replace with your API endpoint

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

  static Future<String> uploadImage() async {
    final dio = Dio(); // With default `Options`.
    String url = ('$baseUrl/users/upload-image');
    
    // Load the image from assets
    final ByteData byteData = await rootBundle.load('assets/bali.png');
    final file = File('${(await getTemporaryDirectory()).path}/bali.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: "bali.png",
      ),
    });

    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjE0ZWE3YWMtMmMyMy00MzhkLWE4NzMtZGEyNTY2ZThlOTQyIiwidXNlcm5hbWUiOiJyb2JpbjEyMzQiLCJleHAiOjE3NDU2OTg0OTV9.43JB6W42Ok1J3ERrBVbVLS2iLpmGvPxMOkDWehIqRkM';

    dio.options.headers['Content-Type'] = 'multipart/form-data';

    // Send the request
    final response = await dio.patch(url, data: formData);

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
