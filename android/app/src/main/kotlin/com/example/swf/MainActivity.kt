package com.example.swf

import android.content.Intent
import android.util.Log
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerClient.InstallReferrerResponse
import com.android.installreferrer.api.InstallReferrerStateListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private lateinit var referrerClient: InstallReferrerClient

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example/install_referrer")
            .setMethodCallHandler { call, result ->
                if (call.method == "getInstallReferrer") {
                    fetchInstallReferrer(result)
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent) // 인텐트를 업데이트하여 나중에 getIntent()로 가져올 수 있도록 합니다.
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val data = intent.data
        if (data != null) {
            val param = data.getQueryParameter("data")
            Log.d("MainActivity", "Received data: $param")
            // 전달된 데이터를 사용하여 로직 처리
        }
    }

    private fun fetchInstallReferrer(result: MethodChannel.Result) {
        referrerClient = InstallReferrerClient.newBuilder(this).build()
        Log.d("InstallReferrer", "Start connection to Play Store")

        referrerClient.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                Log.d("InstallReferrer", "onInstallReferrerSetupFinished: responseCode = $responseCode")

                when (responseCode) {
                    InstallReferrerResponse.OK -> {
                        // Successfully connected
                        val response = referrerClient.installReferrer
                        val referrerUrl: String = response.installReferrer
                        val referrerUrl2: String = response.getInstallReferrer();
                        val referrerClickTime: Long = response.referrerClickTimestampSeconds
                        val appInstallTime: Long = response.installBeginTimestampSeconds
                        val instantExperienceLaunched: Boolean = response.googlePlayInstantParam

                        Log.d("1InstallReferrer", "Install Referrer: $referrerUrl")
                        Log.d("2InstallReferrer", "Click Time: $referrerClickTime")
                        Log.d("1-2InstallReferrer", "Click Time: $referrerUrl2")
                        Log.d("3InstallReferrer", "Install Time: $appInstallTime")
                        Log.d("4InstallReferrer", "Instant Experience: $instantExperienceLaunched")
                        // Send the referrer data back to Flutter
                        val referrerData = mapOf(
                            "installReferrer" to referrerUrl,
                            "referrerClickTime" to referrerClickTime,
                            "appInstallTime" to appInstallTime,
                            "instantExperience" to instantExperienceLaunched
                        )
                        result.success(referrerData)
                    }
                    InstallReferrerResponse.FEATURE_NOT_SUPPORTED -> {
                        Log.e("InstallReferrer", "FEATURE_NOT_SUPPORTED: API not supported on this device.")
                        result.error("FEATURE_NOT_SUPPORTED", "API not supported on this device.", null)
                    }
                    InstallReferrerResponse.SERVICE_UNAVAILABLE -> {
                        Log.e("InstallReferrer", "SERVICE_UNAVAILABLE: Service unavailable.")
                        result.error("SERVICE_UNAVAILABLE", "Service unavailable.", null)
                    }
                }
            }

            override fun onInstallReferrerServiceDisconnected() {
                Log.w("InstallReferrer", "Install Referrer service disconnected.")
                // Handle service disconnection
            }
        })
    }

    override fun onDestroy() {
        super.onDestroy()
        // Clean up the connection when the activity is destroyed
        Log.d("InstallReferrer", "End connection to Play Store")
        referrerClient.endConnection()
    }
}
