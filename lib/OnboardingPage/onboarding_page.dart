import 'package:flutter/cupertino.dart';
import 'package:fitness_app/Widgets/CirclePainter/circle_painter.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingData {
  final String image;
  final String title;
  final String desc;

  _OnboardingData({
    required this.image,
    required this.title,
    required this.desc,
  });
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  //ignore: unused_field
  int _currentPage = 0;

  final List<_OnboardingData> onboardingData = [
    _OnboardingData(
      image: 'assets/onboarding/Onboarding-1.png',
      title: 'Track Your Goal',
      desc:
          "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
    ),
    _OnboardingData(
      image: 'assets/onboarding/Onboarding-2.png',
      title: 'Get Burn',
      desc:
          "Let’s keep burning, to achieve your goals, it hurts only temporarily, if you give up now you will be in pain forever",
    ),
    _OnboardingData(
      image: 'assets/onboarding/Onboarding-3.png',
      title: 'Eat Well',
      desc:
          "Let's start a healthy lifestyle with us, we can determine your diet every day. Healthy eating is fun",
    ),
    _OnboardingData(
      image: 'assets/onboarding/Onboarding-4.png',
      title: 'Improve Sleep Quality',
      desc:
          "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImages();
  }

  void precacheImages() {
    for (var data in onboardingData) {
      precacheImage(AssetImage(data.image), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(children: [
      // PageView.builder(
      //   controller: _pageController,
      //   itemCount: onboardingData.length,
      //   onPageChanged: (int page) {
      //     setState(() {
      //       _currentPage = page;
      //     });
      //   },
      //   itemBuilder: (context, index) {
      //     return _OnboardingPageContent(data: onboardingData[index]);
      //   },
      // ),
      Positioned(
          bottom: 40.0,
          right: 30.0,
          child: Stack(children: [
            const Text("Gago", style: TextStyle(color: Color(0xFF000000))),
            Container(
              width: 60,
              height: 60,
              child: CustomPaint(
                painter: CirclePainter(startAngle: 0.5),
                child: const Text(
                  "Gago",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFF000000),
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ])),
    ]));
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(data.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 290),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: CupertinoColors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              data.desc,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Color(0xFF7B6F72),
                fontSize: 14.0,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
