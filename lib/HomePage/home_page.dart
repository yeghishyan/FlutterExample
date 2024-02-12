import 'package:flutter/cupertino.dart';

import 'package:fitness_app/Widgets/Button/scalable_button.dart';
import 'package:fitness_app/OnboardingPage/onboarding_page.dart';
import 'package:fitness_app/Widgets/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: linearBlue())),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Image.asset(
                    'assets/appLogo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Everybody Can Train",
                  style: TextStyle(
                    color: Color(0xFF7B6F72),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: ScalableButton(
                      color: CupertinoColors.white,
                      minSize: 60,
                      borderRadius: const BorderRadius.all(Radius.circular(99)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const OnboardingPage()),
                        );
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return linearBlue().createShader(bounds);
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
