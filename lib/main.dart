import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/routeGenerator.dart';
import 'package:projects/utils/routes.dart';

void main() async {
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

