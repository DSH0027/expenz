import 'package:expenz/models/onboarding_models.dart';

class OnboardingData {
  static final List<OnboardingModels> onboardingDataList = [
    OnboardingModels(
      image: "assets/images/onboard_1.png",
      title: "Gain total control of your money",
      description: "Become your own money manager and make every cent count",
    ),
    OnboardingModels(
      image: "assets/images/onboard_2.png",
      title: "Know where your money goes",
      description: "Track your transaction easily,with categories and financial report ",
    ),
    OnboardingModels(
      image: "assets/images/onboard_3.png",
      title: "Planning ahead",
      description: "Setup your budget for each category so you in control",
    ),
  ];
}
