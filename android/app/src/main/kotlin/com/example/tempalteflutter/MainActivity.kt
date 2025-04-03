package com.example.tempalteflutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.sabpaisa.integration/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "callSabPaisaSdk") {
                val args = call.arguments as List<String>
                val txnStatus = "Success"
                val txnId = "TXN123456"

                result.success(listOf(txnStatus, txnId))
            } else {
                result.notImplemented()
            }
        }
    }
}

