import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String selectedLanguage = 'Balinese';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Adjusted height
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('NusaSmart'),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.shop),
                onPressed: () {
                  // Handle shop button press
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const MonetizationRow(), // Added the extracted row here
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: selectedLanguage,
                items: <String>['Indonesian', 'Balinese', 'Javanese']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle leaderboard button press
                },
                icon: const Icon(Icons.leaderboard),
                label: const Text('Leaderboard'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MonetizationRow extends StatelessWidget {
  const MonetizationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Icon(Icons.monetization_on),
        Text('100'),
        Icon(Icons.local_fire_department),
        Text('50'),
        Icon(Icons.ac_unit),
        Text('30'),
      ],
    );
  }
}