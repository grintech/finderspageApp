import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/postsVideoScreens/postsHomeScreens/postsNavBarScreen.dart';
import 'package:projects/screens/Events/event_calendar.dart';
import 'package:projects/screens/Profile/edit_profile.dart';
import 'package:projects/screens/Profile/profile.dart';
import 'package:projects/screens/Profile/termsPrivacyScreen.dart';
import 'package:projects/screens/authScreens/forgot_password.dart';
import 'package:projects/screens/authScreens/login.dart';
import 'package:projects/screens/authScreens/reset_password.dart';
import 'package:projects/screens/authScreens/signup.dart';
import 'package:projects/screens/homeScreens/bottomNavScreen.dart';
import 'package:projects/screens/homeScreens/communityScreens/communityDetailScreen.dart';
import 'package:projects/screens/homeScreens/communityScreens/communityListScreen.dart';
import 'package:projects/screens/homeScreens/home_page.dart';
import 'package:projects/screens/homeScreens/jobScreens/jobDetailScreen.dart';
import 'package:projects/screens/homeScreens/jobScreens/jobListScreen.dart';
import 'package:projects/screens/homeScreens/notifications.dart';
import 'package:projects/screens/homeScreens/shopScreens/shop.dart';
import 'package:projects/screens/homeScreens/shopScreens/shop_single.dart';
import 'package:projects/utils/commonWidgets/defaultScreen.dart';
import 'package:projects/utils/routes.dart';

import '../postsVideoScreens/postsProfileScreens/settingScreens/settingScreen.dart';
import '../screens/authScreens/welcome.dart';
import '../screens/homeScreens/estateScreens/estateDetailScreen.dart';
import '../screens/homeScreens/estateScreens/estateListScreen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    Widget widgetScreen;
    final args = settings.arguments;

    switch (settings.name){
      case Routes.welcome:
        widgetScreen = Welcome();
        break;
      case Routes.loginRoute:
        widgetScreen = Login();
        break;
      case Routes.signupRoute:
        widgetScreen = Signup();
        break;
      case Routes.forgetPasswordRoute:
        widgetScreen = ForgotPassword();
        break;
      case Routes.resetPasswordRoute:
        widgetScreen = ResetPassword();
        break;
      case Routes.homeRoute:
        widgetScreen = BottomNavScreen();
        break;
      case Routes.profileRoute:
        widgetScreen = Profile();
        break;
      case Routes.editProfileRoute:
        widgetScreen = EditProfile();
        break;
      case Routes.shop:
        widgetScreen = ShopPage();
        break;
      case Routes.shopSingle:
        widgetScreen = ShopSingle(slug: args as String);
        break;
      case Routes.notificationRoute:
        widgetScreen = Notifications();
        break;
      case Routes.eventsRoute:
        widgetScreen = EventCalendar();
        break;
      case Routes.jobList:
        widgetScreen = JobListScreen();
        break;
      case Routes.jobDetail:
        widgetScreen = JobDetailScreen();
        break;
      case Routes.estateList:
        widgetScreen = EstateListScreen();
        break;
      case Routes.estateDetail:
        widgetScreen = EstateDetailScreen();
        break;
      case Routes.communityList:
        widgetScreen = CommunityListScreen();
        break;
      case Routes.communityDetail:
        widgetScreen = CommunityDetailScreen();
        break;
      case Routes.termsPrivacy:
        widgetScreen = TermsPrivacyScreen();
        break;
      case Routes.defaultScreen:
        widgetScreen = DefaultScreen();
        break;


        //Posts Screens
      case Routes.postsHome:
        return GetPageRoute(
          routeName: Routes.postsHome,
          page: () => PostsNavBarScreen(),
          settings: settings,
          binding: BindingsBuilder(() => Get.lazyPut(() => PostsHomeController())),
        );
      case Routes.postsSetting:
        widgetScreen = PostsSettingScreen();
        break;
      default:
        widgetScreen = _errorRoute();

    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        settings: settings,
        transition: Transition.rightToLeft
    );
  }
  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found'),
      ),
    );
  }
}