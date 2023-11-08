package com.example.riverpod_practice

import io.flutter.embedding.android.FlutterActivity
import  com.example.riverpod_practice.LaunchexternalappPlugin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        LaunchexternalappPlugin.registerWith(flutterEngine, this)
    }
}
