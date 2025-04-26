import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nusastra/pages/home_page.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/pages/translate_page.dart';
import 'package:nusastra/pages/maps_page.dart';
import 'package:nusastra/styles/color_styles.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorStyles.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          enableFeedback: false,
          onTap: onTapHandler,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: GoogleFonts.poppins(
            color: ColorStyles.ochre1000,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            color: ColorStyles.grey500,
          ),
          selectedItemColor: ColorStyles.ochre1000,
          unselectedItemColor: ColorStyles.grey500,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/home.svg',
              ),
              label: "Home",
              activeIcon: SvgPicture.asset('assets/home_filled.svg'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/nusasmart.svg',
              ),
              label: "NusaSmart",
              activeIcon: SvgPicture.asset(
                'assets/quiz_filled.png',
              ),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: GestureDetector(
                  child: Container(),
                  onTap: null,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/nusafriend.svg',
              ),
              label: "NusaFriend",
              activeIcon: SvgPicture.asset(
                'assets/friends_filled.png',
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/maps.svg',
              ),
              label: "NusaMaps",
              activeIcon: SvgPicture.asset(
                'assets/maps_filled.png',
              ),
            )
          ],
        ),
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TranslatePage()),
              );
            },
            elevation: 0.0,
            child: SvgPicture.asset('assets/language.png'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    ]);
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return HomePage();
    } else if (selectedIndex == 1) {
      return QuizPage();
    } else if (selectedIndex == 2) {
      return TranslatePage();
    } else if (selectedIndex == 3) {
      return MapsPage();
    }
    return MapsPage();
  }
}
