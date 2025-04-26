import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nusastra/models/app_model.dart';
import 'package:nusastra/pages/login_page.dart';
import 'package:nusastra/pages/register_page.dart';
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
            SizedBox(
              height: 36,
            ),
            Consumer<AppModel>(
              builder: (context, value, child) {
                var setter = context.read<AppModel>();
                setter.setCamera(camera);
                return Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    height: 1.2,
                    letterSpacing: 0,
                  ),
                );
              },
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Ayo jelajahi berbagai bahasa daerah di Indonesia 👋",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.2,
                letterSpacing: 0,
                color: Color(0xFFAFACA9),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 64,
            ),
            Image.asset("assets/start.png"),
            SizedBox(
              height: 48,
            ),
            FilledButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(334, 53)),
                backgroundColor: WidgetStateProperty.all(Color(0xFF482B0C)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Daftar"),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.2,
                    letterSpacing: 0,
                    color: Color(0xFFAFACA9),
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  child: Text(
                    "Masuk",
                    style: TextStyle(color: Color(0xFF905718)),
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
