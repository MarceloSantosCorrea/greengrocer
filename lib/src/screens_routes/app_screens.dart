import 'package:get/get.dart';

import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/base/base_screen.dart';
import '../screens/splash/splash_screen.dart';

abstract class AppScreens {
  static final pages = <GetPage>[
    GetPage(
      name: ScreensRoutes.splashInRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: ScreensRoutes.signInRoute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: ScreensRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: ScreensRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}

abstract class ScreensRoutes {
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashInRoute = '/splash';
  static const String baseRoute = '/';
}
