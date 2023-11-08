import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_practice/core/channel/launch_app.dart';
import 'package:riverpod_practice/route_name.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(RouteName.shopList),
            child: const Text('move to shop list'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: moveTestPage, child: const Text('test Button')),
        ]),
      ),
    );
  }

  void moveTestPage() async {
    if (await LaunchApp.isAppInstalled(androidPackageName: 'com.google.android.apps.adm') ?? false) {
      await LaunchApp.openApp(androidPackageName: 'com.google.android.apps.adm');
    }
  }
}
