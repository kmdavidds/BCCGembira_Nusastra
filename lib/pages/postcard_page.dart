import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Friend {
  final String name;
  final String avatar;

  Friend({required this.name, required this.avatar});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );
  }
}

class PostcardPage extends StatefulWidget {
  const PostcardPage({super.key});

  @override
  State<PostcardPage> createState() => _PostcardPageState();
}

class _PostcardPageState extends State<PostcardPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Friend> _friends = [];
  bool _isLoading = true;
  
  // Selected color for the postcard
  Color _selectedColor = const Color(0xFFF4B7B6); // Pink by default
  
  // List of available colors for the postcard
  final List<Color> _colors = [
    const Color(0xFFF4B7B6), // Pink
    const Color(0xFFB6E8B8), // Green
    const Color(0xFFF0F089), // Yellow
    const Color(0xFFB5EDEE), // Cyan
    Colors.white,           // White
  ];
  
  // Track if the card was sent successfully
  bool _cardSent = false;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final String response = await rootBundle.loadString('assets/friends.json');
      final List<dynamic> friendsData = json.decode(response);
      
      setState(() {
        _friends = friendsData.map((data) => Friend.fromJson(data)).toList();
        _isLoading = false;
      });
  }

  void _sendPostcard() {
    // Show success screen
    setState(() {
      _cardSent = true;
    });
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF482B0C),
          title: const Text('Loading...', style: TextStyle(color: Colors.white)),
        ),
        body: const Center(child: CircularProgressIndicator(color: Color(0xFF905718))),
      );
    }

    // Show success screen if card was sent
    if (_cardSent) {
      return _buildSuccessScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF482B0C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kartu Pos Digital',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Kirim kartu pos digital ke teman yang anda tambahkan',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilihan Warna',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              
              // Color selection
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _colors.map((color) {
                  final bool isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected 
                              ? const Color(0xFF482B0C) 
                              : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // Message input
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Tulis disini...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Send button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _messageController.text.isEmpty ? null : _sendPostcard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF905718),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: Colors.grey[400],
                  ),
                  child: const Text(
                    'Kirim',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email illustration
            Image.asset(
              'assets/email_sent.png', 
              width: 160,
              height: 160,
              // If the asset doesn't exist, you might want to use a placeholder:
              errorBuilder: (context, error, stackTrace) => 
                  Icon(Icons.mark_email_read, size: 160, color: Colors.amber),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Kartu Pos Berhasil Terkirim!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF482B0C),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}