import 'package:flutter/material.dart';
import 'package:tech_taste/ui/_core/app_colors.dart';
import 'package:tech_taste/ui/_core/app_text_styles.dart';
import 'package:tech_taste/ui/home/home_screen.dart';
import 'package:tech_taste/ui/_core/widgets/web_constrained_box.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: WebConstrainedBox(
        child: Stack(
          children: [
            Image.asset('assets/banners/banner_splash.png'),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 32,
                  children: [
                    Image.asset('assets/logo.png', width: 192),
                    Column(
                      children: [
                        Text(
                          "Um parceiro inovador para sua",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          "melhor experiência culinária!",
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        },
                        child: Text("Bora!"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            Positioned(
              bottom: 24.0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Desenvolvido por github.com/vitoriapguimaraes",
                  style: AppTextStyles.caption.copyWith(fontSize: 11.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
