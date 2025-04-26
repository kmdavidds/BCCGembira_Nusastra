import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Message {
  final String senderName;
  final String senderAvatar;
  final String text;
  final DateTime time;
  final int? likes;
  final String? replyTo;
  final String? replyText;

  Message({
    required this.senderName,
    required this.senderAvatar,
    required this.text,
    required this.time,
    this.likes,
    this.replyTo,
    this.replyText,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderName: json['senderName'],
      senderAvatar: json['senderAvatar'],
      text: json['text'],
      time: DateTime.parse(json['time']),
      likes: json['likes'],
      replyTo: json['replyTo'],
      replyText: json['replyText'],
    );
  }
}

class Community {
  final String name;
  final String avatar;
  final String memberCount;
  final List<Message> messages;

  Community({
    required this.name,
    required this.avatar,
    required this.memberCount,
    required this.messages,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      name: json['name'],
      avatar: json['avatar'],
      memberCount: json['memberCount'],
      messages: (json['messages'] as List)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList(),
    );
  }
}

class CommunityChat extends StatefulWidget {
  final String communityId;

  const CommunityChat({super.key, required this.communityId});

  @override
  State<CommunityChat> createState() => _CommunityChatState();
}

class _CommunityChatState extends State<CommunityChat> {
  final TextEditingController _messageController = TextEditingController();
  Community? _community;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response = await rootBundle.loadString('assets/community_chats.json');
      final jsonData = await json.decode(response);
      
      // Find the community with matching ID
      final communityData = jsonData.firstWhere(
        (comm) => comm['name'] == widget.communityId,
        orElse: () => null,
      );
      
      if (communityData != null) {
        setState(() {
          _community = Community.fromJson(communityData);
          _isLoading = false;
        });
      }
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF482B0C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(_community!.avatar),
              radius: 18,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _community!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _community!.memberCount,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Date header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'Today',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          // Message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _community!.messages.length,
              itemBuilder: (context, index) {
                final message = _community!.messages[index];
                return _buildMessageItem(message);
              },
            ),
          ),
          
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.sentiment_satisfied_alt, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Write here',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_camera_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD98324),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        // Would typically send the message to a backend
                        setState(() {
                          // _community!.messages.add(
                          //   Message(
                          //     senderName: 'You',
                          //     senderAvatar: 'assets/avatar.png',
                          //     text: _messageController.text,
                          //     time: DateTime.now(),
                          //   ),
                          // );
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    final bool isCurrentUser = message.senderName == 'You';
    final timeString = DateFormat('HH:mm').format(message.time);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) 
            CircleAvatar(
              backgroundImage: AssetImage(message.senderAvatar),
              radius: 16,
            )
          else
            const SizedBox(width: 32),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: isCurrentUser 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  Text(
                    message.senderName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[300],
                    ),
                  ),
                if (message.replyTo != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.replyTo!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[300],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          message.replyText!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(message.text),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        timeString,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (message.likes != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          message.likes.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!isCurrentUser)
            IconButton(
              icon: const Icon(Icons.favorite_border, size: 16),
              color: Colors.grey,
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            const SizedBox(width: 16),
        ],
      ),
    );
  }
}