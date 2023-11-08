import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class LaunchApp {
  LaunchApp._();

  //method declaration
  static const MethodChannel _channel = MethodChannel('launch_app');

  // getter for platform version
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool?> isAppInstalled({String? iosUrlScheme, String? androidPackageName}) async {
    String packageName = Platform.isIOS ? iosUrlScheme! : androidPackageName!;
    if (packageName.isEmpty) {
      throw ArgumentError('Package name cannot be empty');
    }
    bool isAppInstalled = await _channel.invokeMethod('isAppInstalled', {'package_name': packageName});
    return isAppInstalled;
  }

  static Future<int> openApp({
    String? iosUrlScheme,
    String? androidPackageName,
    String? appStoreLink,
    bool? openStore,
  }) async {
    String? packageName = Platform.isIOS ? iosUrlScheme : androidPackageName;
    String packageVariableName = Platform.isIOS ? 'iosUrlScheme' : 'androidPackageName';
    if (packageName == null || packageName.isEmpty) {
      throw ArgumentError('$packageVariableName cannot be empty');
    }

    if (Platform.isIOS && appStoreLink == null && openStore == null) {
      openStore = false;
    }

    return await _channel.invokeMethod('openApp', {
      'package_name': packageName,
      'app_store_link': appStoreLink,
      'open_store': openStore,
    }).then((value) {
      if (value == 'app_opened') {
        Logger().i('app opened');
        return 1;
      } else {
        if (value == "navigated_to_store") {
          if (Platform.isIOS) {
            Logger().i("Redirecting to AppStore as the app is not present on the device");
          } else {
            Logger().i("Redirecting to Google Play Store as the app is not present on the device");
          }
        } else {
          Logger().i(value);
        }
        return 0;
      }
    });
  }
}
