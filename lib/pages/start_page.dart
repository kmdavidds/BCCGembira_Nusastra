import 'package:flutter/material.dart';
import 'package:nusastra/pages/test.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 40,
            ),
            Text("Selamat Datang!"),
            Text("Ayo jelajahi berbagai bahasa daerah di Indonesia  👋"),
            Image.asset("assets/start.png"),
            FilledButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestPage()));
                },
                child: Text("Daftar")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? "),
                GestureDetector(
                  child: Text(
                    "Masuk",
                    style: TextStyle(color: Color(0xFF443627)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
