import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/photo_page.dart';
import 'package:nusastra/services/api_service.dart';
import 'package:nusastra/styles/color_styles.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? _sourceLanguage = 'Indonesian';
  String? _targetLanguage = 'Balinese';
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: "id_ID");
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _textController.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<AppModel>(
        builder: (context, appModel, child) {
          return Scaffold(
            bottomNavigationBar: customNavBar(appModel, appModel),
            appBar: AppBar(
              backgroundColor: const Color(0xFF482B0C), // Dark brown
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Image.asset('assets/alpha.png')),
                ],
              ),
              title: Row(
                children: [
                  Image.asset('assets/nusalingo.png', height: 24),
                  const SizedBox(width: 8),
                  const Text('Language Translator',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildTextTab(),
               
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          
          const SizedBox(height: 16),
          _buildInputCard(),
          const SizedBox(height: 16),
          _buildOutputCard(),
        ],
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorStyles.ochre800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Balinese",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: ColorStyles.ochre300)),
              Icon(Icons.close, color: Color(0xFF482B0C)),
            ],
          ),
          const SizedBox(height: 12),
          Text("Ngranjing", style: TextStyle(color: Colors.white),),
          const SizedBox(height: 16),
          
        ],
      ),
    );
  }

  Widget _buildOutputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorStyles.ochre300,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Arti dan Asal-usul",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: ColorStyles.ochre800)),
          const SizedBox(height: 12),
          Text(
            '"Ngranjing" dalam bahasa Bali berarti "masuk" atau "memasuki" suatu tempat atau wilayah. Kata ini sering digunakan dalam konteks adat, upacara, atau aktivitas sehari-hari. Misalnya, dalam upacara keagamaan, "ngranjing" dipakai untuk menggambarkan proses memasuki pura atau area suci setelah melalui ritual pembersihan atau permohonan izin. Secara budaya, "ngranjing" juga mengandung makna menghormati tempat yang dimasuki, dengan sikap sopan dan penuh kesadaran spiritual. Dalam penggunaan sehari-hari, kata ini bisa merujuk pada tindakan biasa seperti masuk rumah, kantor, atau tempat lain dengan etika yang sesuai norma setempat.',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.copy, size: 20, color: Color(0xFF482B0C)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _translatedText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.star_border,
                    size: 20, color: Color(0xFF482B0C)),
                onPressed: () {
                  // Save to favorites
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget customNavBar(AppModel value, AppModel setter) {
    return Container(
      clipBehavior: Clip.none,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF8EADA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Bottom row with 5 navigation items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  iconPath: 'assets/home.png',
                  label: 'Home',
                  index: 0,
                  currentIndex: value.currentPageIndex,
                  onTap: () => setter.setCurrentPageIndex(0),
                ),
                _buildNavItem(
                  iconPath: 'assets/nusasmart.png',
                  label: 'NusaSmart',
                  index: 1,
                  currentIndex: value.currentPageIndex,
                  onTap: () => setter.setCurrentPageIndex(1),
                ),
                // Empty space for center button
                Container(width: 60),
                _buildNavItem(
                  iconPath: 'assets/nusafriend.png',
                  label: 'NusaFriend',
                  index: 3,
                  currentIndex: value.currentPageIndex,
                  onTap: () => setter.setCurrentPageIndex(3),
                ),
                _buildNavItem(
                  iconPath: 'assets/nusamaps.png',
                  label: 'NusaMaps',
                  index: 4,
                  currentIndex: value.currentPageIndex,
                  onTap: () => setter.setCurrentPageIndex(4),
                ),
              ],
            ),
          ),
          // Center raised button
          Positioned(
            top: -25,
            left: 155,
            child: GestureDetector(
              onTap: () => setter.setCurrentPageIndex(2),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF482B0C),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/nusalingo.png',
                      width: 28,
                      height: 28,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isSelected ? const Color(0xFF482B0C) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF482B0C) : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
