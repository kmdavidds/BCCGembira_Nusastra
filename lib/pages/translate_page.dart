import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/photo_page.dart';
import 'package:nusastra/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF482B0C), // Dark brown
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(icon: Image.asset('assets/alpha.png')),
              Tab(icon: Image.asset('assets/scanner.png')),
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
            _buildCameraTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLanguageDropdown(_sourceLanguage!, (value) {
                setState(() {
                  _sourceLanguage = value;
                });
              }),
              const SizedBox(width: 8),
              const Icon(Icons.swap_horiz, color: Color(0xFF482B0C)),
              const SizedBox(width: 8),
              _buildLanguageDropdown(_targetLanguage!, (value) {
                setState(() {
                  _targetLanguage = value;
                });
              }),
            ],
          ),
          const SizedBox(height: 16),
          _buildInputCard(),
          const SizedBox(height: 16),
          _buildOutputCard(),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(
      String currentValue, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFf8f4fc),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          items: ['Indonesian', 'Balinese', 'Javanese']
              .map((lang) => DropdownMenuItem(
                    value: lang,
                    child: Text(lang),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFf8f4fc),
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
              Text(_sourceLanguage!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF482B0C))),
              Icon(Icons.close, color: Color(0xFF482B0C)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _textController,
            maxLines: null,
            decoration: const InputDecoration.collapsed(
              hintText: '',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF6C4112), // Brown color
                    shape: BoxShape.circle),
                child: IconButton(
                  icon:
                      const Icon(Icons.mic, color: Colors.white), // White icon
                  onPressed: () {
                    _speechToText.isNotListening
                        ? _startListening()
                        : _stopListening();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Consumer<AppModel>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      String translation = await ApiService.translate(
                          value.token, _textController.text, _sourceLanguage!, _targetLanguage!);
                      setState(() {
                        _translatedText = translation;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE58A1F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Translate',
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOutputCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFf8f4fc),
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
          Text(_targetLanguage!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF482B0C))),
          const SizedBox(height: 12),
          Text(
            _translatedText,
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

  Widget _buildCameraTab() {
    return Consumer<AppModel>(builder: (context, value, child) {
      return Center(child: TakePictureScreen(camera: value.camera!));
    });
  }
}
