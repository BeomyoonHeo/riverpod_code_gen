import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_practice/app_route.dart';
import 'package:riverpod_practice/custom_logger.dart';
import 'package:riverpod_practice/locator/locator.dart';
import 'package:riverpod_practice/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItLocator.dependencies();
  runApp(ProviderScope(observers: [CustomLogger()], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'riverpod example',
      debugShowCheckedModeBanner: false,
      routes: AppRoute.routes,
      initialRoute: RouteName.initialScreen,
    );
  }
}
