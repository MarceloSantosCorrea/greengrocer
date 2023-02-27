import 'package:get/get.dart';

import '../screens/auth/view/sign_in_screen.dart';
import '../screens/auth/view/sign_up_screen.dart';
import '../screens/base/base_screen.dart';
import '../screens/base/binding/navigation_binding.dart';
import '../screens/cart/binding/cart_binding.dart';
import '../screens/home/binding/home_binding.dart';
import '../screens/orders/binding/orders_binding.dart';
import '../screens/product/product_screen.dart';
import '../screens/splash/splash_screen.dart';

abstract class AppScreens {
  static final pages = <GetPage>[
    GetPage(
      name: ScreensRoutes.productRoute,
      page: () => ProductScreen(),
    ),
    GetPage(
      name: ScreensRoutes.splashInRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: ScreensRoutes.signInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: ScreensRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: ScreensRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class ScreensRoutes {
  static const String productRoute = '/product';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashInRoute = '/splash';
  static const String baseRoute = '/';
}
