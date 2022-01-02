package com.example.analog_alarm_clock

import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import java.lang.UnsupportedOperationException

class MyService : Service() {
    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val builder = NotificationCompat.Builder(this, "alarms")
                .setContentText("This is running in background")
                .setContentTitle("Flutter Background")
                .setSmallIcon(R.drawable.app_icon)
            startForeground(100, builder.build())
        }
    }

    override fun onBind(intent: Intent): IBinder? {
        // TODO: Return the communication channel to the service.
        throw UnsupportedOperationException("Not yet implemented")
    }
}