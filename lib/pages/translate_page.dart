import 'package:flutter/material.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String? _sourceLanguage;
  String? _targetLanguage;
  final TextEditingController _textController = TextEditingController();
  int _currentIndex = 2; // Set default index to "translate"

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Text'),
              Tab(text: 'Camera'),
            ],
          ),
          title: const Text('Translate'),
        ),
        body: TabBarView(
          children: [
            _buildTextTab(),
            _buildCameraTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // Add navigation logic here if needed
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.translate),
              label: 'Translate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Friend',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Maps',
            ),
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
                items: ['English', 'Spanish', 'French']
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
                items: ['English', 'Spanish', 'French']
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
          ElevatedButton(
            onPressed: () {
              // Add your translation logic here
              final text = _textController.text;
              final from = _sourceLanguage;
              final to = _targetLanguage;
              if (text.isNotEmpty && from != null && to != null) {
                // Perform translation
                print('Translating "$text" from $from to $to');
              }
            },
            child: const Text('Translate'),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraTab() {
    return const Center(
      child: Text('Camera translation coming soon!'),
    );
  }
}
