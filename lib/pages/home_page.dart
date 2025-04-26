import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/quiz_page.dart';
import 'package:nusastra/pages/test.dart';
import 'package:nusastra/pages/translate_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClassrooms();
  }

  Future<void> _loadClassrooms() async {
    // try {
    //   var appModel = context.read<AppModel>();
    //   var classrooms = await ApiService.getClassrooms(appModel.token);
    //   appModel.setClassrooms(classrooms);
    // } catch (e) {
    //   debugPrint(e.toString());
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }a
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, value, child) {
        var setter = context.read<AppModel>();
        return Scaffold(
          bottomNavigationBar: homeNavigation(value, setter),
          body: [
            isLoading ? _loadingWidget() : homeClassroom(value),
            QuizPage(),
            TranslatePage(),
            TestPage(),
            TestPage(),
          ][value.currentPageIndex],
        );
      },
    );
  }

  Widget _loadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Center homeClassroom(AppModel value) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Selamat Datang!"),
                  Text(value.displayName),
                ],
              ),
              const Icon(Icons.person_pin),
            ],
          ),
        ],
      ),
    );
  }

  NavigationBar homeNavigation(AppModel value, AppModel setter) {
    return NavigationBar(
      backgroundColor: const Color(0xFFF8EADA),
      onDestinationSelected: (int index) {
        setter.setCurrentPageIndex(index);
      },
      indicatorColor: Color(0xFF482B0C),
      selectedIndex: value.currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white),
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.question_mark, color: Colors.white),
          icon: Icon(Icons.question_mark),
          label: 'NusaSmart',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.language, color: Colors.white),
          icon: Icon(Icons.language),
          label: 'NusaLingo',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.people, color: Colors.white),
          icon: Icon(Icons.people),
          label: 'NusaFriend',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.map, color: Colors.white),
          icon: Icon(Icons.map),
          label: 'NusaMaps',
        ),
      ],
    );
  }
}
