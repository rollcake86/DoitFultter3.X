package com.rollcake.native_example

import android.app.AlertDialog
import android.os.Build
import android.util.Base64
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.dev/info"
    private val CHANNEL2 = "com.flutter.dev/encryto"
    private val CHANNEL3 = "com.flutter.dev/dialog"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if(call.method == "getDeviceInfo"){
                // 이 부분에서 실행할 함수 제작
                if(call.method == "getDeviceInfo"){
                    val deviceInfo = getDeviceInfo()
                    result.success(deviceInfo)
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL2).setMethodCallHandler { call, result ->
            if(call.method == "getEncryto"){
                val data = call.arguments.toString().toByteArray();
                val changeText = Base64.encodeToString(data, Base64.DEFAULT)
                result.success(changeText)
            }else if(call.method == "getDecode"){
                val changedText = Base64.decode(call.arguments.toString() , Base64.DEFAULT)
                result.success(String(changedText))
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL3)
            .setMethodCallHandler { call, result ->
                if (call.method == "showDialog") {
                    AlertDialog.Builder(this)
                        .setTitle("Flutter")
                        .setMessage("네이티브에서 출력하는 창입니다")
                        .show()
                }
            }


    }

    private fun getDeviceInfo() : String {
        val sb = StringBuffer()
        sb.append(Build.DEVICE+"\n")
        sb.append(Build.BRAND+"\n")
        sb.append(Build.MODEL+"\n")
        return sb.toString()
    }
}
