import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nusastra/models/token.dart';

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

  static Future<String> uploadImage(String token, File file) async {
    final dio = Dio(); // With default `Options`.
    String url = ('$baseUrl/chats/create-chat-ocr');
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    dio.options.headers['Authorization'] = 'Bearer $token';

    dio.options.headers['Content-Type'] = 'multipart/form-data';

    debugPrint(file.path.split('/').last);
    final response = await dio.post(url, data: formData);

    return response.toString();
  }

  static Future<String> buy(String token, String type) async {
    final url = Uri.parse('$baseUrl/payments/create-payment');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'type': type,
      }),
    );


    if (response.statusCode != 200) {
      throw HttpException('Failed to register: ${response.body}');
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final payments = responseBody['payments'] as Map<String, dynamic>?;
    if (payments == null) {
      throw HttpException('Payments field is missing in the response: ${response.body}');
    }
    final snapURL = payments['snap_url'] as String?;
    if (snapURL == null) {
      throw HttpException('snap_url field is missing in the payments object: ${response.body}');
    }
    debugPrint(snapURL);
    return snapURL;
  }

  static Future<String> translate(String token, String content) async {
    final url = Uri.parse('$baseUrl/chats/create-chat');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "content":
            'Change your actual language setting, translate this from Indonesian to Balinese $content',
        "type": "text",
      }),
    );

    if (response.statusCode != 200) {
      throw HttpException('Failed to register: ${response.body}');
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final translation = responseBody['translation'] as String?;
    if (translation == null) {
      throw HttpException(
          'Translation field is missing in the response: ${response.body}');
    }
    return translation;
  }
}
