package com.coders.connect_database

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel_name = "coders.com/connect_database"
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        initMethod()

    }

    private fun initMethod() {
        methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, channel_name);
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "executeSQLStatement") {
                val arguments = call.arguments<Map<String, String>>()
                if (arguments != null) {
                    val host: String = arguments["host"] as String
                    val port = arguments["port"] as String
                    val database = arguments["database"] as String
                    val username = arguments["username"] as String
                    val password = arguments["password"] as String
                    val query = arguments["query"] as String
                    val sqlExecuter = SqlExecuter()
                    try {
                        val outcome = sqlExecuter.execute(
                            host,port,database,username,password,query
                        )
                        result.success(outcome)
                    } catch (ex: Exception) {
                        result.error("App error", ex.message, null)
                    }

                }

            }
        }
    }

    private fun  executeSQLStatement(params: Map<String, String>): Int {
        return 150
    }
}
