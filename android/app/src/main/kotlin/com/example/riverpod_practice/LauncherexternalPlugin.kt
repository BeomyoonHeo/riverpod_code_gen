package com.example.riverpod_practice

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.Context
import android.content.Intent
import android.text.TextUtils
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine

/** LaunchExternalAppPlugin  */
class LaunchexternalappPlugin : MethodCallHandler, FlutterPlugin {
    private var context: Context? = null
    private var channel: MethodChannel? = null
    constructor()
    private constructor(context: Context) {
        this.context = context
    }

    @Override
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "launch_app")
        channel!!.setMethodCallHandler(LaunchexternalappPlugin(flutterPluginBinding.applicationContext))
    }

    @Override
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel!!.setMethodCallHandler(null)
    }

    @Override
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE)
        } else if (call.method.equals("isAppInstalled")) {
            if (!call.hasArgument("package_name") || TextUtils.isEmpty(call.argument<String>("package_name").toString())) {
                result.error("ERROR", "Empty or null package name", null)
            } else {
                val packageName: String = call.argument<String>("package_name").toString()
                result.success(isAppInstalled(packageName))
            }
        } else if (call.method.equals("openApp")) {
            val packageName: String? = call.argument("package_name")
            result.success(openApp(packageName!!, call.argument<String>("open_store").toString()))
        } else {
            result.notImplemented()
        }
    }

    private fun isAppInstalled(packageName: String): Boolean {
        return try {
            context!!.packageManager.getPackageInfo(packageName, 0)
            true
        } catch (ignored: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun openApp(packageName: String, openStore: String): String {
        if (isAppInstalled(packageName)) {
            val launchIntent: Intent? = context!!.packageManager.getLaunchIntentForPackage(packageName)
            if (launchIntent != null) {
                // null pointer check in case package name was not found
                launchIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context!!.startActivity(launchIntent)
                return "app_opened"
            }
        } else {
            if (openStore !== "false") {
                val intent1 = Intent(Intent.ACTION_VIEW)
                intent1.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                intent1.data = android.net.Uri.parse("https://play.google.com/store/apps/details?id=$packageName")
                context!!.startActivity(intent1)
                return "navigated_to_store"
            }
        }
        return "something went wrong"
    }
    companion object{
        @JvmStatic
        fun registerWith(flutterEngine: FlutterEngine, context: Context) {
            val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "launch_app")
            channel.setMethodCallHandler(LaunchexternalappPlugin(context))
        }
    }
}