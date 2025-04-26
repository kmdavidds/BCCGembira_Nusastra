import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/styles/color_styles.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
              SizedBox(
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
                        title: Consumer<AppModel>(
                          builder: (context, value, child) {
                          return Text(
                            'Selamat datang, ${value.displayName}!',
                            style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            ),
                          );
                          },
                        ),
                 
                        subtitle: Text(
                          'Mau belajar bahasa apa hari ini?',
                          style: TextStyle(
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
                                      style: TextStyle(
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
                                      SizedBox(width: 4),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/coin.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 4),
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
              _QuizCard(
                title: 'Makan Makanan Tradisional (Bali)',
                points: '20 Zp',
                onPressed: () {},
              ),
              _QuizCard(
                title: 'Bertemu Teman Lama (Bali)',
                points: '20 Zp',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              const _SectionTitle(title: 'Video Edukatif'),
              const _VideoList(),
              const SizedBox(height: 64),
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
        Text(title, style: TextStyle(fontSize: 12)),
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
        style: TextStyle(
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
      height: 130,
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

class _VideoList extends StatelessWidget {
  const _VideoList();

  @override
  Widget build(BuildContext context) {
    final videos = [
      'assets/balivid.png',
      'assets/pentingvid.png',
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                IntrinsicWidth(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      videos[index],
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Aksi ketika video diklik
                        print('Video ${videos[index]} dipilih');
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final String title;
  final String points;
  final VoidCallback? onPressed;

  const _QuizCard({
    required this.title,
    this.points = '20 Zp',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width - 32, // Ensure fixed width
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBFE),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorStyles.ochre1000,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF9C23C),
                  ),
                  child: Image.asset(
                    'assets/coin.png',
                    width: 16,
                    height: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  points,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xFFA7A7A7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyles.ochre600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    'Mulai',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white,
                    ),
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