import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LanguageData {
  final String name;
  final String region;
  final int speakers;
  final String status;
  final String alphabet;
  final String classification;
  final LatLng position;

  LanguageData({
    required this.name,
    required this.region,
    required this.speakers,
    required this.status,
    required this.alphabet,
    required this.classification,
    required this.position,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      name: json['name'],
      region: json['region'],
      speakers: json['speakers'],
      status: json['status'],
      alphabet: json['alphabet'],
      classification: json['classification'],
      position: LatLng(json['position']['latitude'], json['position']['longitude']),
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();
  LanguageData? _selectedLanguage;
  bool _isDetailVisible = false;
  List<LanguageData> _filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    _loadLanguages();
  }

  Future<void> _loadLanguages() async {
    final String response = await rootBundle.loadString('assets/languages.json');
    final List<dynamic> data = jsonDecode(response);
    final List<LanguageData> languages = data.map((json) => LanguageData.fromJson(json)).toList();
    setState(() {
      _filteredLanguages = languages;
    });
  }

  void _onMarkerTapped(LanguageData language) {
    setState(() {
      _selectedLanguage = language;
      _isDetailVisible = true;
    });

    // Animasi ke lokasi bahasa yang dipilih
    _mapController.move(language.position, 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMap(),
          _buildSearchBar(),
          if (_isDetailVisible && _selectedLanguage != null)
            _buildLanguageDetail(_selectedLanguage!),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: LatLng(-2.5489, 118.0149), // Pusat Indonesia
        zoom: 5.0,
        minZoom: 3.0,
        maxZoom: 18.0,
        onTap: (_, __) {
          setState(() {
            _isDetailVisible = false;
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.nusastra.app',
        ),
        MarkerLayer(
          markers: _filteredLanguages.map((language) {
            return Marker(
              point: language.position,
              width: 40,
              height: 40,
              builder: (context) => GestureDetector(
                onTap: () => _onMarkerTapped(language),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCA6B2D),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26), // Fixed from withOpacity(0.1)
              blurRadius: 8,
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari bahasa atau daerah...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) {
            // Implementasi pencarian
            setState(() {
              if (value.isEmpty) {
                _filteredLanguages = List.from(_filteredLanguages);
              } else {
                _filteredLanguages = _filteredLanguages
                    .where((language) =>
                        language.name.toLowerCase().contains(value.toLowerCase()) ||
                        language.region.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildLanguageDetail(LanguageData language) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF443627),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  language.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  language.region,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  '${language.speakers~/1000000} juta penutur',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow('Status', language.status),
                      _buildInfoRow('Alfabet', language.alphabet),
                      _buildInfoRow('Klasifikasi', language.classification),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCA6B2D),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text('Belajar'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCA6B2D),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text('Komunitas'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
