package com.passmana.app

import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.biometric.BiometricPrompt.AUTHENTICATION_RESULT_TYPE_UNKNOWN
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    //method channel name
    private val biometricsChannelName = "com.passmana.app/biometrics"

    //calling method name
    private val verifyBiometricMethodName = "verifyBiometric"

    // method channel variable
    private lateinit var biometricsChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Initialize the method channel once the flutter engine is attached.
        biometricsChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, biometricsChannelName)

        // setting method handler, whenever we invoke a method from flutter
        // on method channel, this handler will be triggered.
        biometricsChannel.setMethodCallHandler { call, result ->
            if (call.method == verifyBiometricMethodName) {
                authenticateWithBiometrics(result)
            } else {
                //Sending false result event if method is not implemented
                result.success(false)
            }
        }
    }

    private fun authenticateWithBiometrics(result: MethodChannel.Result) {
        var resultSent = false
        val executor = ContextCompat.getMainExecutor(this)
        val biometricPrompt = BiometricPrompt(
            this as FragmentActivity, executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    if (errorCode != 10 && !resultSent) {
                        //Sending false result instead of generating error
                        result.success(false)
                        resultSent = true
                    }
                }

                override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
                    super.onAuthenticationSucceeded(authResult)
                    if (!resultSent) {
                        if (authResult.authenticationType != AUTHENTICATION_RESULT_TYPE_UNKNOWN) {
                            //Sending true result if authentication success and authentication type
                            //is not unknown
                            result.success(true)
                        } else {
                            //Sending false result if authentication success but authentication type
                            // is unknown
                            result.success(false)
                        }
                        resultSent = true
                    }
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    if (!resultSent) {
                        //Sending false result instead of generating error
                        result.success(false)
                        resultSent = true
                    }
                }
            }
        )

        val promptInfo = BiometricPrompt.PromptInfo.Builder().setTitle("Biometric Authentication")
            .setSubtitle("Verify your Biometric Credential or Use your Device Credential to Use This App")
            .setConfirmationRequired(true)
            .setAllowedAuthenticators(
                BIOMETRIC_STRONG or DEVICE_CREDENTIAL
            ).build()

        biometricPrompt.authenticate(promptInfo)
    }
}
