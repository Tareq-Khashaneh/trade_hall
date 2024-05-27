package com.example.flutter_app;

import android.app.KeyguardManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class BootReceiver extends BroadcastReceiver {
    @Override
//    public void onReceive(Context context, Intent intent) {
//        if (intent != null && Intent.ACTION_USER_PRESENT.equals(intent.getAction())) {
//            // Screen is unlocked, start the service to launch the app
//            Intent serviceIntent = new Intent(context, AppLaunchService.class);
//            context.startService(serviceIntent);
//        }
//    }
    public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(Intent.ACTION_BOOT_COMPLETED)) {
            // Start your app's main activity
            Intent startIntent = new Intent(context, MainActivity.class);
            startIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(startIntent);
        }
    }

}
