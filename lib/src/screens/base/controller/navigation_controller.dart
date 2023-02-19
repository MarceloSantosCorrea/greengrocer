import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabls {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  @override
  void onInit() {
    super.onInit();

    initNavigation(
      pageController: PageController(initialPage: NavigationTabls.home),
      currentIndex: NavigationTabls.home,
    );
  }

  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex.value = currentIndex;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}
