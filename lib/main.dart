import 'dart:io';

import 'package:flutter/material.dart';
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
  runApp(MyApp(initialRoute));
}

Future<String> findInitialRoute() async{
  String initialRoute = Routes.welcome;
  return initialRoute;
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

