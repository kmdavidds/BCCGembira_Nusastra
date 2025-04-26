import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/styles/color_styles.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Toko',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: ColorStyles.ochre1000,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Penawaran Spesial'),
            const SizedBox(height: 8),
            SpecialOfferCard(
              icon: Icons.ac_unit,
              iconColor: Color(0xFF50A0EA), // Streak Freeze icon color
              title: 'Streak Freeze',
              description:
                  'Melindungi streak kamu apabila terlewat mengerjakan kuis dalam satu hari',
              type: "freeze",
              price: 'Rp10.000',
            ),
            const SizedBox(height: 12),
            SpecialOfferCard(
              icon: Icons.lock,
              iconColor: Color(0xFF905718), // Premium icon color
              title: 'Konten Premium (1 bulan)',
              description:
                  'Akses berbagai konten premium dengan bebas selama 1 bulan',
              type: "premium",
              price: 'Rp15.000',
            ),
            const SizedBox(height: 24),
            buildSectionTitle('Penukaran Koin'),
            const SizedBox(height: 8),
            CoinExchangeCard(
              imagePath: 'assets/museum.png', // change with your asset
              title: 'Voucher Museum Angkut',
              description:
                  'Dapatkan potongan Rp10.000 untuk satu tiket masuk Museum Angkut di Batu, Malang',
              cost: '2000 Zp',
            ),
            const SizedBox(height: 12),
            CoinExchangeCard(
              imagePath: 'assets/batu.png',
              title: 'Voucher Batu Spectacular Night',
              description:
                  'Dapatkan potongan Rp10.000 untuk satu tiket masuk Museum Angkut di Batu, Malang',
              cost: '2500 Zp',
            ),
            const SizedBox(height: 12),
            CoinExchangeCard(
              imagePath: 'assets/tanahlot.png',
              title: 'Voucher Tanah Lot',
              description:
                  'Dapatkan potongan Rp10.000 untuk satu tiket masuk Museum Angkut di Batu, Malang',
              cost: '3000 Zp',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF482B0C),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String price;
  final String type;

  const SpecialOfferCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(type);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SizedBox(
              child: Icon(icon, size: 64, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF482B0C),
                      )),
                  const SizedBox(height: 4),
                  Text(description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                  const SizedBox(width: 12),
                  Text(price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF482B0C),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinExchangeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String cost;

  const CoinExchangeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF482B0C),
                      )),
                  const SizedBox(height: 6),
                  Text(description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on,
                          size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(cost,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
