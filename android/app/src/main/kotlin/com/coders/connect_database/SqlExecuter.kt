package com.coders.connect_database

import kotlinx.coroutines.*
import java.sql.ResultSet
import java.sql.ResultSetMetaData
import java.sql.Statement

class SqlExecuter {
    /*
    fun <P, R> CoroutineScope.executeAsyncTask(
        onPreExecute: () -> Unit,
        doInBackground: suspend (suspend (P) -> Unit) -> R,
        onPostExecute: (R) -> Unit,
        onProgressUpdate: (P) -> Unit
    ) = launch {
        onPreExecute()

        val result = withContext(Dispatchers.IO) {
            doInBackground {


                withContext(Dispatchers.Main) { onProgressUpdate(it) }
                var connection = ConnectionManager().connectionClass(
                    host,port,database,username,password
                )

                if (connection != null) {
                    val statement: Statement = connection.createStatement()
                    val resultSet: ResultSet = statement.executeQuery(query)
                    val records =  kotlin.collections.ArrayList<HashMap<String, String>>()
                    if (resultSet != null) {
                        val md: ResultSetMetaData = resultSet.metaData
                        val columns: Int = md.columnCount

                        while (resultSet.next()) {
                            val row = HashMap<String, String>(columns)
                            for (i in 1..columns) {
                                row[md.getColumnName(i)] = resultSet.getString(i)
                            }
                            records.add(row)
                        }

                    }
                    return@doInBackground records
                }


            }
        }
        onPostExecute(result)
    }
    */

    fun execute(
        host: String,
        port: String,
        database: String,
        username: String,
        password: String,
        query: String
    ) :ArrayList<HashMap<String, String>> {

        var records: ArrayList<HashMap<String, String>>
        runBlocking(Dispatchers.IO) {
            val gettingRecords = async { executeStatement(host, port, database, username, password, query) }
            val someThing = runBlocking<ArrayList<HashMap<String, String>>>{
                records = gettingRecords.await()
                return@runBlocking records
            }

            records = someThing
        }
        return records

    }

    private fun executeStatement (
        host: String,
        port: String,
        database: String,
        username: String,
        password: String,
        query: String
    ) : ArrayList<HashMap<String, String>> {
        val connection = ConnectionManager().connectionClass(
            host,port,database,username,password
        )


        val records =  ArrayList<HashMap<String, String>>()

        if (connection != null) {
            val statement: Statement = connection.createStatement()
            val resultSet: ResultSet = statement.executeQuery(query)
            if (resultSet != null) {
                val md: ResultSetMetaData = resultSet.metaData
                val columns: Int = md.columnCount
                print("columnCount: $columns")
                while (resultSet.next()) {
                    val row = HashMap<String, String>(columns)
                    for (i in 1..columns) {
                        row[md.getColumnName(i)] = resultSet.getString(i)
                    }

                    records.add(row)
                }

            }

        }
        connection?.close()
        return records
    }
}