import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/pages/result_page.dart';
import 'package:nusastra/pages/score_page.dart';
import 'package:nusastra/styles/color_styles.dart'; // pastikan ada file ini

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = List.filled(5, null);
  List<bool> answerLocked = List.filled(5, false);
  bool quizSubmitted = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': '"Ngiring Ngajeng"',
      'options': ['Mari makan', 'Mari pergi', 'Mari lihat', 'Mari dengar'],
      'correctAnswer': 0
    },
    {
      'question': '"Mangan Nggih"',
      'options': ['Sudah makan?', 'Mari makan', 'Ayo minum', 'Enak sekali'],
      'correctAnswer': 1
    },
    {
      'question': '"Dolanan Nang Ngendi?"',
      'options': [
        'Mau ke mana?',
        'Main di mana?',
        'Dari mana?',
        'Tinggal di mana?'
      ],
      'correctAnswer': 1
    },
    {
      'question': '"Punapi Gatra?"',
      'options': ['Apa kabar?', 'Bagaimana?', 'Siapa nama?', 'Berapa usia?'],
      'correctAnswer': 0
    },
    {
      'question': '"Sugeng Enjang"',
      'options': [
        'Selamat pagi',
        'Selamat siang',
        'Selamat malam',
        'Selamat tidur'
      ],
      'correctAnswer': 0
    },
  ];

  void selectAnswer(int answerIndex) {
    if (answerLocked[currentQuestionIndex]) return;

    setState(() {
      selectedAnswers[currentQuestionIndex] = answerIndex;
      answerLocked[currentQuestionIndex] = true;
    });

    bool isCorrect =
        answerIndex == questions[currentQuestionIndex]['correctAnswer'];
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void submitQuiz() {
    // Calculate score
    int score = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i]['correctAnswer']) {
        score++;
      }
    }

    // Navigate to ResultPage with score data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(
          correctAnswers: score,
          totalQuestions: questions.length,
        ),
      ),
    );
  }

  Color _getOptionBackgroundColor(int optionIndex) {
    if (selectedAnswers[currentQuestionIndex] == optionIndex) {
      if (optionIndex == questions[currentQuestionIndex]['correctAnswer']) {
        return Colors.green[50]!;
      } else {
        return Colors.red[50]!;
      }
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 8,
        title: Text(
          'Kuis',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyles.ochre1000,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Color(0xFF3DBA49)),
              minHeight: 5,
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3DBA49),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                questions[currentQuestionIndex]['question'],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions[currentQuestionIndex]['options'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: answerLocked[currentQuestionIndex]
                          ? null
                          : () => selectAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getOptionBackgroundColor(index),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            questions[currentQuestionIndex]['options'][index],
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          if (selectedAnswers[currentQuestionIndex] == index)
                            Icon(
                              index ==
                                      questions[currentQuestionIndex]
                                          ['correctAnswer']
                                  ? Icons.check
                                  : Icons.close,
                              color: index ==
                                      questions[currentQuestionIndex]
                                          ['correctAnswer']
                                  ? Colors.green
                                  : Colors.red,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedAnswers[currentQuestionIndex] != null &&
                selectedAnswers[currentQuestionIndex] !=
                    questions[currentQuestionIndex]['correctAnswer'])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Jawaban Benar: ${questions[currentQuestionIndex]['options'][questions[currentQuestionIndex]['correctAnswer']]}',
                  style: GoogleFonts.poppins(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: selectedAnswers[currentQuestionIndex] == null
                  ? null
                  : currentQuestionIndex == questions.length - 1
                      ? submitQuiz // Changed from submitQuiz to call the navigation function
                      : nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedAnswers[currentQuestionIndex] != null &&
                            selectedAnswers[currentQuestionIndex] ==
                                questions[currentQuestionIndex]['correctAnswer']
                        ? Colors.green
                        : Color(0xFFE88B00),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                currentQuestionIndex == questions.length - 1
                    ? 'Submit'
                    : 'Continue',
                style: GoogleFonts.poppins(
                  color: Colors.white,
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