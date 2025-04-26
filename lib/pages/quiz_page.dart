import 'package:flutter/material.dart';
import 'package:nusastra/pages/shop_page.dart';

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
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: const Color(0xFF482B0C), // Dark brown color
          elevation: 0,
          automaticallyImplyLeading: false, // Removes the leading widget
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/nusalingo.png', height: 24),
                  const SizedBox(width: 8),
                  const Text('NusaSmart',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              GestureDetector(
                onTap: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShopPage()));},
                child: Image.asset('assets/shop.png', height: 24),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MonetizationRow(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedLanguage,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
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
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.leaderboard, color: Colors.white),
                    label: const Text(
                      'Leaderboard',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C4112),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            buildSectionTitle('Kuis Harian'),
            buildQuizCard('Makan Makanan Tradisional'),
            buildQuizCard('Percakapan Sehari-hari'),
            const SizedBox(height: 24),
            buildSectionTitle('Kuis Mingguan'),
            buildQuizCard('Berbelanja di Pasar'),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.2, // 120% line-height
            color: Color(0xFF482B0C),
          ),
        ),
      ),
    );
  }

  Widget buildQuizCard(String quizTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: 339,
        height: 129,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBFE),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF482B0C),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF9C23C),
                      ),
                      child: const Icon(
                        Icons.monetization_on,
                        size: 16,
                        color: Color(0xFFD3883E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '20 Zp',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFFA7A7A7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD98324),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Mulai',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    letterSpacing: 0.1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonetizationRow extends StatelessWidget {
  const MonetizationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF482B0C), // same brown background
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.amber),
              SizedBox(width: 4),
              Text('66', style: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.redAccent),
              SizedBox(width: 4),
              Text('16', style: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.lightBlueAccent),
              SizedBox(width: 4),
              Text('0/3', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
