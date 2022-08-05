import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:taxi_app/widgets/login.dart';
import 'package:taxi_app/widgets/splash.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          //
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        onBoardData: onBoardData,
        titleStyles: TextStyle(
          color: Colors.yellow[700],
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Colors.brown.shade300,
        ),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.yellow,
          activeColor: Colors.yellow[700],
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            "Passer",
            style: TextStyle(color: Colors.yellow[700]),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.yellow[700],
                ),
                child: Text(
                  state.isLastPage ? "Terminé" : "Suivant",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Demander une course en taxi",
    description:
        "Utilisez votre application mobile SenTaxi pour demander une course.",
    imgUrl: "assets/pick_taxi.png",
  ),
  const OnBoardModel(
    title: "Choisissez vos destinations",
    description: "Le taxi vous emmène à vos multiples emplacements.",
    imgUrl: 'assets/route.png',
  ),
  const OnBoardModel(
    title: "Arriver à destination à temps",
    description: "Profitez de votre trajet et arrivez à destination à temps.",
    imgUrl: 'assets/user_pickup.png',
  ),
];
