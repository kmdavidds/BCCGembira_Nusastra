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

  static Future<String> uploadImage(File file) async {
    final dio = Dio(); // With default `Options`.
    String url = ('$baseUrl/chats/create-chat-ocr');
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    dio.options.headers['Authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZjE0ZWE3YWMtMmMyMy00MzhkLWE4NzMtZGEyNTY2ZThlOTQyIiwidXNlcm5hbWUiOiJyb2JpbjEyMzQiLCJleHAiOjE3NDU2NzQ5Mjh9.Y4JIHvBT4qteVeA-QtPtseWg1_R4DHNbdODvPTUc5HE';

    dio.options.headers['Content-Type'] = 'multipart/form-data';

    debugPrint(file.path.split('/').last);
    final response = await dio.post(url, data: formData);

    return response.toString();
  }
}
