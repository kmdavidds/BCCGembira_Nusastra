import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/pages/home_page.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/styles/color_styles.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScorePage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    int earnedPoints = correctAnswers * 4; // contoh per jawaban 4 poin
    int totalZp = 50 + earnedPoints; // contoh base 50 Zp

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const QuizPage()));
          },
        ),
        titleSpacing: 8,
        title: Text(
          'Hasil Kuis',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyles.ochre1000,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Hebat!',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/trophy.png', // <- ganti sesuai lokasi gambar piala kamu
              height: 220,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Skor: $correctAnswers/$totalQuestions',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+$earnedPoints poin',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3DBA49),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '$totalZp Zp',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' (+$earnedPoints)',
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE88B00),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Keluar',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // Aksi bagikan hasil
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFFE88B00)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Bagikan Hasil',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFE88B00),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}