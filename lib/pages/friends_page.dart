import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nusastra/pages/community_chat_page.dart';
import 'package:nusastra/pages/postcard_page.dart';

// Friend model
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

// Community model
class Community {
  final String name;
  final String avatar;
  bool joined;

  Community({required this.name, required this.avatar, required this.joined});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      joined: json['joined'] as bool,
    );
  }
}

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Friend> _friends = [];
  List<Community> _communities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from JSON files
  Future<void> _loadData() async {
    // Load friends data
    final String friendsResponse = await rootBundle.loadString('assets/friends.json');
    final friendsData = await json.decode(friendsResponse);
    
    // Load communities data
    final String communitiesResponse = await rootBundle.loadString('assets/communities.json');
    final communitiesData = await json.decode(communitiesResponse);
    
    setState(() {
      _friends = List<Friend>.from(friendsData.map((data) => Friend.fromJson(data)));
      _communities = List<Community>.from(communitiesData.map((data) => Community.fromJson(data)));
      _isLoading = false;
    });
  }

  void _openCommunityChat(String communityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityChat(communityId: communityName),
      ),
    );
  }

  void _openPostcardPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostcardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF905718)))
        : SingleChildScrollView(
          child: Column(
            children: [
              // Friend count indicator
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF905718), // Ochre color from your styles
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_friends.length} dari 20 teman',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari teman atau komunitas...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              
              // Friends section with postcard button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF905718)),
                        const SizedBox(width: 8),
                        const Text(
                          'Teman Anda',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF905718),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: _openPostcardPage,
                      icon: const Icon(Icons.email, size: 16),
                      label: const Text('Kartu Pos'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF905718),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Friend list - limited to 3 items to avoid overflow
              ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _friends.length > 3 ? 3 : _friends.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(_friends[index].avatar),
                          backgroundColor: Colors.grey[300],
                        ),
                        title: Text(
                          _friends[index].name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Use Future.delayed to avoid setState during build
                            Future.delayed(Duration.zero, () {
                              setState(() {
                                _friends.removeAt(index);
                              });
                            });
                          },
                        ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
              
              // Show more button
              TextButton(
                onPressed: () {
                  // Handle show more
                },
                child: const Text(
                  'Tampilkan Lebih Banyak',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              
              // Communities section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.groups, color: Color(0xFF905718)),
                        const SizedBox(width: 8),
                        const Text(
                          'Komunitas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF905718),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle view details
                      },
                      child: const Text(
                        'Lihat lebih detail',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Communities list - limited to 3 items to avoid overflow
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _communities.length > 3 ? 3 : _communities.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(_communities[index].avatar),
                          backgroundColor: Colors.grey[300],
                        ),
                        title: Text(
                          _communities[index].name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: _communities[index].joined 
                          ? () => _openCommunityChat(_communities[index].name)
                          : null,
                        trailing: _communities[index].joined 
                          ? IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              onPressed: () => _openCommunityChat(_communities[index].name),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                // Use Future.delayed to avoid setState during build
                                Future.delayed(Duration.zero, () {
                                  setState(() {
                                    _communities[index].joined = true;
                                  });
                                });
                              },
                              child: const Text('Ikuti'),
                            ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}