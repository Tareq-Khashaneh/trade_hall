package com.example.flutter_app;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.os.Build;

import androidx.core.app.ActivityCompat;

import java.util.List;

import android.os.Handler;
public class WifiController {
    @SuppressLint("StaticFieldLeak")
    public static Context context;
    public static WifiManager wifiManager;
    public static void enableWifi() {
       if (wifiManager != null && !wifiManager.isWifiEnabled()) {
            wifiManager.setWifiEnabled(true);
        }
    }
    public static void disableWifi() {
        if (wifiManager != null && wifiManager.isWifiEnabled()) {
            wifiManager.setWifiEnabled(false);
        }
    }
    static void connectToWifiNetwork(String ssid, String password) {
        int netId = -1 ;
        WifiController.enableWifi();
        try {
            Thread.sleep(3000); // 5000 milliseconds = 5 seconds
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        boolean scanSuccess = wifiManager.startScan();
        if (!scanSuccess) {
            System.out.println("scanSuccess "+ scanSuccess);
            return;
        }
        else{
            try {
                Thread.sleep(2000); // 5000 milliseconds = 5 seconds
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            @SuppressLint("MissingPermission") List<ScanResult> scanResults = wifiManager.getScanResults();
            for (ScanResult scanResult : scanResults) {
                if (scanResult.SSID.equals(ssid)) {
                    WifiConfiguration wifiConfig = new WifiConfiguration();
                    wifiConfig.SSID = "\"" + scanResult.SSID + "\"";
                    wifiConfig.preSharedKey = "\"" + password + "\"";
                    netId = wifiManager.addNetwork(wifiConfig);
                    System.out.println("network " + netId);
                    if(netId != -1){
                        wifiManager.disconnect();
                        wifiManager.enableNetwork(netId, true);
                    }
                    break;
                }
            }
        }
    }
}
