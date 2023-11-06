import 'package:flutter/material.dart';
import 'package:riverpod_practice/presentation/view/initial_screen.dart';
import 'package:riverpod_practice/presentation/view/home/home_view.dart';
import 'package:riverpod_practice/route_name.dart';

abstract class AppRoute {
  const AppRoute._();

  static final Map<String, WidgetBuilder> routes = {
    RouteName.initialScreen: (BuildContext context) => const InitialScreen(),
    RouteName.shopList: (BuildContext context) => const HomeView(),
  };
}
