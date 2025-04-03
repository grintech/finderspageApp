import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/routeGenerator.dart';
import 'package:projects/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await StorageHelper.init();
  String initialRoute = await findInitialRoute();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(initialRoute)));
  configLoading();
}

Future<String> findInitialRoute() async{
  String initialRoute = Routes.welcome;
  StorageHelper storageHelper = StorageHelper();
  if(storageHelper.getUserToken() != null){
    initialRoute = Routes.postsHome;
    print("user token -----> ${storageHelper.getUserToken()}");
  }else{
    initialRoute = Routes.welcome;
  }
  return initialRoute;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 65.0
    ..radius = 12.0
    ..progressColor = purpleColor
    ..backgroundColor = Color(0xFFFFFF)
    ..indicatorColor = purpleColor
    ..textColor = purpleColor
    ..textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
    ..maskColor = Color(0xFFFFFF)
    ..textPadding = const EdgeInsets.only(bottom: 20)
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
    ..userInteractions = false
    ..dismissOnTap = false;
}


class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp(this.initialRoute, {super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          surfaceTintColor: whiteColor
        ),
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: whiteColor
      ),
      builder: EasyLoading.init(builder: (BuildContext? context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context!);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child ?? Container(),
        );
      }),
      navigatorObservers: [ClearFocusOnPush()],
      initialRoute: Routes.welcome,
      onGenerateRoute: RouteGenerator.generateRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RouteGenerator.generateRoute(RouteSettings(name: initialRoute)),
        ];
      },

    );
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

