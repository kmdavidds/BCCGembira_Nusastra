import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/home_widget.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/pages/test.dart';
import 'package:nusastra/pages/translate_page.dart';
import 'package:nusastra/pages/maps_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, value, child) {
        var setter = context.read<AppModel>();
        return Scaffold(
          bottomNavigationBar: customNavBar(value, setter),
          body: [
            HomeWidget(),
            QuizPage(),
            TranslatePage(),
            TestPage(),
            MapsPage(), // Add MapsPage here
          ][value.currentPageIndex],
        );
      },
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
