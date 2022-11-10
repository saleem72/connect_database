package com.coders.connect_database

import android.annotation.SuppressLint
import android.os.StrictMode
import android.os.StrictMode.ThreadPolicy
import android.util.Log
import java.sql.Connection
import java.sql.DriverManager


class ConnectionManager {
    @SuppressLint("NewApi")
    fun connectionClass (
        host: String,
        port: String,
        database: String,
        username: String,
        password: String
    ) : Connection? {

        val policy = ThreadPolicy.Builder().permitAll().build()
        StrictMode.setThreadPolicy(policy)


        var connection: Connection? = null
        var connectionURL: String? = null

        try {
            Class.forName("net.sourceforge.jtds.jdbc.Driver");
            // connectionURL= "jdbc:jtds:sqlserver://"+ host + ":"+ port+";"+ "databasename="+ database+";user="+username+";password="+password+";";
            connectionURL=
                "jdbc:jtds:sqlserver://$host:$port;databasename=$database;user=$username;password=$password;";


            connection = DriverManager.getConnection(connectionURL);

        } catch (ex: Exception) {
            ex.message?.let { Log.e("Error", it) }
            throw Exception(ex.message)
        }

        return connection



    }
}