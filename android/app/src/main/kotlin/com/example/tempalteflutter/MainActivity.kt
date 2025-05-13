package com.example.tempalteflutter

import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import android.app.Activity
import android.content.Intent
import com.example.sabpaisapaymentgateway.PaymentGatewayActivity
import com.example.sabpaisapaymentgateway.PaymentResponse
import com.example.sabpaisapaymentgateway.SabPaisaPaymentGateway
import com.example.sabpaisapaymentgateway.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Objects

class MainActivity : FlutterActivity(){

    private val CHANNEL = "com.example.payment/sdk"
    private val PAYMENT_REQUEST_CODE = 100
    private var paymentResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startPayment") {
                paymentResult = result

                // Extract arguments from Flutter
                val args = call.arguments as? Map<String, Any>
                val payerName = args?.get("payerName") as? String ?: ""
                val payerEmail = args?.get("payerEmail") as? String ?: ""
                val payerMobile = args?.get("payerMobile") as? String ?: ""
                val amount = args?.get("amount") as? String ?: ""

                startPayment(payerName, payerEmail, payerMobile, amount)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startPayment(
            payerName: String,
            payerEmail: String,
            payerMobile: String,
            amount: String
    ) {
        val config = SabPaisaPaymentGateway().apply {
            this.payerName = payerName
            this.payerEmail = payerEmail
            this.payerMobile = payerMobile
            this.amount = amount
            clientTxnId = java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 16)
            clientCode = "ANKI85"
            transUserName = "ankitgoyal27@gmail.com"
            transUserPassword = "ANKI85_SP16856"
            sabPaisaUrl = "https://securepay.sabpaisa.in/SabPaisa/sabPaisaInit?v=1"
            authKey = "1vECJOsqBbcAKDkE"
            authIV = "CkLHVtwx2stHVT2j"
        }

        val intent = Intent(this, PaymentGatewayActivity::class.java).apply {
            putExtra(PaymentGatewayActivity.EXTRA_PAYMENT_CONFIG, config)
        }
        startActivityForResult(intent, PAYMENT_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == PAYMENT_REQUEST_CODE) {
            val response = data?.getParcelableExtra<PaymentResponse>(PaymentGatewayActivity.EXTRA_PAYMENT_RESPONSE)
            if (resultCode == Activity.RESULT_OK && response != null) {
                val resultData = mapOf(
                        "status" to response.status,
                        "clientTxnId" to response.clientTxnId,
                        "amount" to response.amount,
                        "payerName" to response.payerName
                )
                paymentResult?.success(resultData)
            } else {
                paymentResult?.error("PAYMENT_FAILED", "Payment failed or canceled", null)
            }
            paymentResult = null
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }


}
