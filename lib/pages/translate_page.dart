import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/photo_page.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String? _sourceLanguage;
  String? _targetLanguage;
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF482B0C), // Dark brown color
          elevation: 0,
          automaticallyImplyLeading: false, // Removes the leading back button
          bottom: TabBar(
            tabs: [
              Tab(icon: Image.asset('assets/alpha.png')), // Logo of Aa
              Tab(icon: Image.asset('assets/scanner.png')), // Scanner icon
            ],
          ),
          title: Row(
            children: [
              Image.asset('assets/nusalingo.png', height: 24),
              const SizedBox(width: 8),
              const Text('Language Translator', style: TextStyle(color: Colors.white, fontSize: 16)),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: const Text('From'),
                value: _sourceLanguage,
                items: ['Indonesian', 'Balinese', 'Javanese']
                    .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sourceLanguage = value;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: () {
                  setState(() {
                    final temp = _sourceLanguage;
                    _sourceLanguage = _targetLanguage;
                    _targetLanguage = temp;
                  });
                },
              ),
              DropdownButton<String>(
                hint: const Text('To'),
                value: _targetLanguage,
                items: ['Indonesian', 'Balinese', 'Javanese']
                    .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _targetLanguage = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter text to translate',
            ),
            maxLines: null,
          ),
          const SizedBox(height: 16),
          Text(
            // If listening is active show the recognized words
            _speechToText.isListening
                ? _lastWords
                // If listening isn't active but could be tell the user
                // how to start it, otherwise indicate that speech
                // recognition is not yet ready or not supported on
                // the target device
                : _speechEnabled
                    ? 'Tap the microphone to start listening...'
                    : 'Speech not available',
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: () {
                  // Add your voice input logic here
                  print('Voice input activated');
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      // If not yet listening for speech start, otherwise stop
                      _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,
                  child: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                ),
              ),
            ],
          ),
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
