import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/login_page.dart';
import 'package:nusastra/pages/register_page.dart';
import 'package:nusastra/pages/test.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  final CameraDescription camera;

  const StartPage({super.key, required this.camera});

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
            Consumer<AppModel>(
              builder: (context, value, child) {
                var setter = context.read<AppModel>();
                setter.setCamera(camera);
                return Text("Selamat Datang!");
              },
            ),
            Text("Ayo jelajahi berbagai bahasa daerah di Indonesia  👋"),
            Image.asset("assets/start.png"),
            FilledButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
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
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
