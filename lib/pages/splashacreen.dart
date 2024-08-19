import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vet_app/pages/home/home_page.dart';

class SplashScrenn extends StatelessWidget {
  const SplashScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(""),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Animate(
              onPlay: (controller) => controller.loop(reverse: true, count: 5),
              onComplete: (_) => Navigator.pushReplacementNamed(
                  context, MyHomePage.homePageRoute),
            )
                .custom(
                  curve: Curves.easeOut,
                  duration: 1.seconds,
                  delay: 0.5.seconds,
                  end: 1,
                  begin: 1,
                  builder: (_, value, __) => Icon(
                    Icons.pets,
                    size: 200,
                    color: Colors.blue[300],
                  ),
                )
                .fadeIn()
                .scale(),
            Text(
              "Pets App".toUpperCase(),
              style: const TextStyle(
                fontSize: 40,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            )
                .animate(
                  onPlay: (controller) => controller.loop(
                    reverse: true,
                    period: 1.5.seconds,
                    count: 5,
                  ),
                )
                .tint(
                  color: Color.lerp(Colors.black, Colors.white, 3000),
                )
                .shader()
                .shimmer(
                  color: Colors.blue[300],
                  angle: 20,
                )
          ]),
        ),
      ),
    );
  }
}
