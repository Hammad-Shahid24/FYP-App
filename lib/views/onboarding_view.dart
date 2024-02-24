import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:fypapp/constants/routes.dart";
import "package:fypapp/services/shared_preferences/sp_service.dart";
import "package:introduction_screen/introduction_screen.dart";

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome to DocSpot!',
          body: "DocSpot is a platform that connects patients with doctors and hospitals.",
          image: buildImage("assets/3.svg"),
          decoration: getPageDecoration("assets/bg2.jpg"),
        ),
        PageViewModel(
          title: 'Find the Perfect Doctor',
          body: 'Search for the perfect doctor for your needs.',
          image: buildImage("assets/4.svg"),
          decoration: getPageDecoration("assets/bg3.jpg"),
        ),
        PageViewModel(
          title: 'Manage Your Appointments',
          body: 'Manage your appointments with ease.',
          image: buildImage("assets/2.svg"),
          decoration: getPageDecoration("assets/bg2.jpg"),
        ),
        PageViewModel(
          title: 'Take Control of Your Health',
          body: 'Take control of your health with DocSpot.',
          image: buildImage("assets/5.svg"),
          decoration: getPageDecoration("assets/bg3.jpg"),
        ),
      ],
      onDone: () {
        SharedPreferencesService.start().saveIsOnBoardingDOne(true);
        Navigator.of(context).pushNamedAndRemoveUntil(signInRoute, (route) => false);
      },
      scrollPhysics: const ClampingScrollPhysics(),
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      animationDuration: 600,
      curve: Curves.easeInOutCirc,
      dotsDecorator: getDotsDecorator(),
      freeze: false, // Enable swiping between pages
    );
  }
}

Widget buildImage(String imagePath) {
  return Center(
    child: SvgPicture.asset(
      imagePath,
      width: 450,
      height: 200,
    ),
  );
}

PageDecoration getPageDecoration(String img) {
  return PageDecoration(
    imagePadding: const EdgeInsets.only(top: 120),
    bodyPadding: const EdgeInsets.only(top: 8, left: 20, right: 20),
    titlePadding: const EdgeInsets.only(top: 50),
    bodyTextStyle: const TextStyle(color: Colors.black54, fontSize: 15),
    boxDecoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(img),
        fit: BoxFit.cover,
      ),
    ),
  );
}

DotsDecorator getDotsDecorator() {
  return const DotsDecorator(
    spacing: EdgeInsets.symmetric(horizontal: 2),
    activeColor: Colors.indigo,
    color: Colors.grey,
    activeSize: Size(12, 5),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
  );
}
