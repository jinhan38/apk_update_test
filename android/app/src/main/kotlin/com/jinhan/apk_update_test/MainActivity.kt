package com.jinhan.apk_update_test

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.File


class MainActivity : FlutterActivity() {

    companion object {
        private const val TAG = "MainActivity"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupChannels(flutterEngine.dartExecutor.binaryMessenger)
    }

    private fun setupChannels(messenger: BinaryMessenger) {
        MethodChannel(messenger, "android").setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "update" -> {

                        val path = call.arguments as String

                        executeFile(this, File(path))

                    }
                }
            } catch (e: Exception) {
                Log.e(ContentValues.TAG, "setupChannels: $e")
            }
        }
    }

    private fun executeFile(
        context: Context,
        file: File
    ) {
        try {
            val intent = Intent(Intent.ACTION_VIEW)

            val uri = FileProvider.getUriForFile(context, context.applicationContext.packageName + ".provider", file)
            intent.setDataAndType(uri, "application/vnd.android.package-archive")
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.putExtra(Intent.EXTRA_NOT_UNKNOWN_SOURCE, true)
            context.startActivity(intent)

        } catch (e: Exception) {
            Log.e(TAG, "executeFile(): ${e.message}")
        }
    }

}
