import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/app_route.dart';
import 'package:riverpod_practice/custom_logger.dart';
import 'package:riverpod_practice/presentation/view/custom_loading.dart';
import 'package:riverpod_practice/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(observers: [CustomLogger()], child: const App()));
}

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'riverpod example',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        routes: AppRoute.routes,
        initialRoute: RouteName.initialScreen,
        builder: (context, child) => LoadingState.init()(
              context,
              child ?? const SizedBox.shrink(),
            ));
  }
}
