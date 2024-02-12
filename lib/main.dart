import 'package:flutter/cupertino.dart';
import 'package:fitness_app/HomePage/home_page.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'FitnessApp',
      theme: CupertinoThemeData(
        applyThemeToAll: true,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}