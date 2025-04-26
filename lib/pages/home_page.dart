import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahin ini
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/styles/color_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                height: 240,
                child: Stack(
                  children: [
                    Container(
                      height: 140 + statusBarHeight,
                      padding: EdgeInsets.only(
                        top: statusBarHeight + 16,
                        left: 16,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorStyles.ochre1000,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/lisa.png'),
                          radius: 24,
                        ),
                        title: Text(
                          'Selamat datang, Indah!',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Mau belajar bahasa apa hari ini?',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                          ),
                        ),
                        trailing: Image.asset(
                          'assets/shop.png',
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: 140,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Streak',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/streak.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text('200'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey[300],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Zp Poins',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(
                                        image: AssetImage(
                                          'assets/coin.png',
                                        ),
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text('66 Zp'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              _SectionTitle(title: 'Mau belajar apa hari ini?'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _MenuOption(
                        title: 'NusaLingo',
                        imageAsset: 'assets/laptop_guy.png'),
                    _MenuOption(
                        title: 'NusaSmart', imageAsset: 'assets/book.png'),
                    _MenuOption(
                        title: 'NusaFriend', imageAsset: 'assets/women.png'),
                    _MenuOption(
                        title: 'NusaMaps', imageAsset: 'assets/map_icon.png'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Image.asset('assets/iklan.png'),
              const SizedBox(height: 16),
              _SectionTitle(title: 'Hasil Belajar'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  'assets/hasil_belajar.png',
                ),
              ),

              const SizedBox(height: 16),
              const _SectionTitle(title: 'Berita Terkini'),
              const _NewsCardList(),
              const SizedBox(height: 16),
              const _SectionTitle(title: 'Rekomendasi Kuis'),
              const _QuizCard(title: 'Makan Makanan Tradisional'),
              const _QuizCard(title: 'Bertemu Teman Lama'),
              const SizedBox(height: 16),
              const _SectionTitle(title: 'Video Edukatif'),
              const _VideoList(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;

  const _MenuOption({
    required this.title,
    this.icon,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon != null
            ? Icon(icon)
            : imageAsset != null
                ? Image.asset(
                    imageAsset!,
                    width: 64,
                    height: 64,
                  )
                : Container(),
        const SizedBox(height: 4),
        Text(title, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorStyles.ochre600),
      ),
    );
  }
}

class _NewsCardList extends StatelessWidget {
  const _NewsCardList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130, // Fixed height untuk ListView
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: IntrinsicWidth(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/berita${index + 1}.png',
                  height: 130, // Fixed height
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final String title;

  const _QuizCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: ListTile(
          title: Text(title),
          subtitle: const Text('20 poin'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Mulai'),
          ),
        ),
      ),
    );
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList();

  @override
  Widget build(BuildContext context) {
    final videoAssets = [
      'assets/balivid.png',
      'assets/pentingvid.png',
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: videoAssets.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: IntrinsicWidth(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  videoAssets[index],
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
