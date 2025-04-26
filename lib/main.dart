import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/first_page.dart';
import 'package:nusastra/pages/photo_page.dart';
import 'package:nusastra/pages/question_page.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/pages/result_page.dart';
import 'package:nusastra/pages/start_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nusastra',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const QuizPage());
  }
}
