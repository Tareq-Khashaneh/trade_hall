package com.example.flutter_app;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Typeface;
import android.net.wifi.WifiManager;
import android.provider.Settings;
import android.widget.Toast;

import androidx.annotation.NonNull;
import com.nexgo.oaf.apiv3.APIProxy;
import com.nexgo.oaf.apiv3.DeviceEngine;
import com.nexgo.oaf.apiv3.DeviceInfo;
import com.nexgo.oaf.apiv3.SdkResult;
import com.nexgo.oaf.apiv3.card.mifare.M1CardHandler;
import com.nexgo.oaf.apiv3.device.beeper.Beeper;
import com.nexgo.oaf.apiv3.device.printer.AlignEnum;
import com.nexgo.oaf.apiv3.device.printer.DotMatrixFontEnum;
import com.nexgo.oaf.apiv3.device.printer.FontEntity;
import com.nexgo.oaf.apiv3.device.printer.GrayLevelEnum;
import com.nexgo.oaf.apiv3.device.printer.OnPrintListener;
import com.nexgo.oaf.apiv3.device.printer.Printer;
import com.nexgo.oaf.apiv3.device.reader.CardInfoEntity;
import com.nexgo.oaf.apiv3.device.reader.CardReader;
import com.nexgo.oaf.apiv3.device.reader.CardSlotTypeEnum;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import com.nexgo.oaf.apiv3.device.reader.OnCardInfoListener;
import com.nexgo.oaf.apiv3.platform.Platform;

public class MainActivity extends FlutterActivity {
    String uid ;
    HashSet<CardSlotTypeEnum> slotTypes = new HashSet<>();
    private final int FONT_SIZE_SMALL = 20;
    private static final int NETWORK_SETTINGS_REQUEST_CODE = 1;
    DeviceEngine deviceEngine;
    Platform platform ;
    boolean isTimeOut;
    Map<Object, Object> dataMap = new HashMap<>();
    private final String READCHANNEL = "samples.flutter.dev/read";
    private final String MainChannel = "samples.flutter.dev/mainInfo";
    private final String PrintChannel = "samples.flutter.dev/print";
    Beeper beeper;
    public DeviceInfo deviceInfo;
    Printer printer ;
    CardReader cardReader;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        init();
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), READCHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("readCard")) {
                                cardReaderTest(new ReadCallback(){
                                    @Override
                                    public void onCreditRead(Map data) {
                                        result.success(data);
                                    }
                                });
                            } else if (call.method.equals("stopRead")) {
                                cardReader.stopSearch();
                                result.success(true);
                            } else {
                                result.notImplemented();
                            }
                        });
            new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), MainChannel).setMethodCallHandler(
                    (call, result) -> {
                       switch (call.method){
                           case "setMainSettings":
                               setDefaultSettings();
                               result.success(true);
                               break;
                            case "readDeviceInfo":
                                String deviceSn = readDeviceInfo();
                                result.success(deviceSn);
                                break;
                            case "setDateTime":
                                String dateTime = call.arguments();
                                if(dateTime != null)
                                {
                                    deviceEngine.setSystemClock(dateTime);
                                    result.success(true);
                                } else {
                                    result.notImplemented();
                                }
                                break;
//                            case "enableWifi":
//                                WifiController.enableWifi();
//                                result.success(true);
//                                break;
//                            case "disableWifi":
//                                WifiController.disableWifi();
//                                result.success(true);
//                                break;
                            case "setWifiInfo":
                                String ssid = call.argument("ssid");
                                String password = call.argument("password");
                                if(ssid != null && password != null) {
                                    platform.disableMobileData();
                                    WifiController.connectToWifiNetwork(ssid, password);
                                    result.success(null);
                                }
                                else {
                                    result.notImplemented();
                                }
                                break;
                           case "enableMobileData":
                               WifiController.disableWifi();
                               platform.enableMobileData();
                             result.success(true);
                             break;
                           case "create apn":
                               Map<String, String> map = call.arguments();
                               String name = "",apnName = "",ip = "",port = "";
                               if(map != null){
                                   ip = map.get("ip");
                                   port = map.get("port");
                                   name = map.get("name");
                                   apnName = map.get("apnName");
                               }
                            boolean isCreated =  MobileDataController.createApn(name,apnName,ip,port);
                               result.success(isCreated);
                               break;
                           case "isApnInList":
                               String apn = call.argument("apnName");
                               boolean isAPNInList = MobileDataController.isAPNInList(apn);
                               result.success(isAPNInList);
                               break;
//                           case "deleteApn":
//                               String apnDel = call.argument("apnName");
//                               MobileDataController.deleteApn(apnDel);
//                               result.success(true);
//                               break;
                           case "openNetworkSettings":
                               openNetworkSettings();
                               result.success(true);
                               break;
                           default:
                                result.notImplemented();
                        }
                    }
        );
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), PrintChannel)
                .setMethodCallHandler(
                        (call, result) -> {
                            boolean isEnglish = Boolean.TRUE.equals(call.argument("isEnglish"));
                       if(call.method.equals("print")){
                                String data = call.argument("invoiceTemplate");
                                printInfo(new PrintCallBack() {
                                    @Override
                                    public void print(int status) {
                                        result.success(status);
                                    }
                                }, data, isEnglish);
                            }

                            else {
                                result.notImplemented();
                            }
                        });
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == NETWORK_SETTINGS_REQUEST_CODE) {
            // Notify Flutter side if needed, for now just return to the app
        }
    }

    public void printInfo(PrintCallBack printCallBack, String data,boolean isEnglish) {
        try{
            AlignEnum alignEnum;
            if(isEnglish){
                alignEnum =  AlignEnum.LEFT;
            }else{
                alignEnum = AlignEnum.RIGHT;
            }
            printer.initPrinter();
            printer.appendPrnStr(data, FONT_SIZE_SMALL, alignEnum, false);
            printer.setGray(GrayLevelEnum.LEVEL_0);
            printer.setTypeface(Typeface.DEFAULT);
            printer.setLetterSpacing(5);
            printer.startPrint(false, new OnPrintListener() {
                @Override
                public void onPrintResult(final int retCode) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            System.out.println("was printed");
                            int status = printer.getStatus();
                            printCallBack.print(status);
                        }
                    });
                }
            });
        }catch (Exception e)
        {
            System.out.println("error in java " + e);
        }
    }
    private void openNetworkSettings() {
        Intent intent = new Intent(Settings.ACTION_NETWORK_OPERATOR_SETTINGS);
        startActivityForResult(intent, NETWORK_SETTINGS_REQUEST_CODE);
    }
    public String readDeviceInfo() {
      return deviceInfo.getSn();
    }
    public void setDefaultSettings(){
        platform.disableControlBar();
        platform.disableHomeButton();
        platform.disableTaskButton();
    }
    public interface ReadCallback {
        void onCreditRead(Map data);
    }
    public interface PrintCallBack{
        void print(int status);
    }
    private void cardReaderTest(ReadCallback callback) {
        Thread readThread = new Thread(()-> {
            cardReader.searchCard(slotTypes, 50, new OnCardInfoListener() {
                @Override
                public void onCardInfo(int retCode, CardInfoEntity cardInfo) {
                   try {
                       uid = "";
                       isTimeOut =false;
                       if (retCode == SdkResult.Success) {
                           if (cardInfo != null) {

                               if (cardInfo.getCardExistslot() == CardSlotTypeEnum.RF) {
                                   final M1CardHandler m1CardHandler = deviceEngine.getM1CardHandler();
                                   //step 3 , read UID
                                   uid = m1CardHandler.readUid();
                                   System.out.println("card Id in java " + uid);
                                   dataMap.put("cardId", uid);
                                   dataMap.put("isTimeOut", isTimeOut);
                                   callback.onCreditRead(dataMap);
//                                  beeper.beep((short) -10, (short) 2);
                               }
                           }
                       } else if (retCode == SdkResult.Fail) {
                           System.out.println("ret code was Failed");
                           dataMap.put("cardId", uid);
                           dataMap.put("isTimeOut", isTimeOut);
                           callback.onCreditRead(dataMap);
                       } else {
                           System.out.println("time out ");
                           isTimeOut = true;
                           dataMap.put("cardId", uid);
                           dataMap.put("isTimeOut", isTimeOut);
                           callback.onCreditRead(dataMap);
                       }
                   }catch (Exception e){
                       System.out.println("Exception " + e);
                   }
                }
                @Override
                public void onSwipeIncorrect() {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
//                        Toast.makeText(MainActivity.this, getString(R.string.swip_again), Toast.LENGTH_SHORT).show();
                        }
                    });
                }
                @Override
                public void onMultipleCards() {
                    cardReader.stopSearch();
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
//                        Toast.makeText(MainActivity.this, getString(R.string.search_toomany_cards), Toast.LENGTH_SHORT).show();
                        }
                    });
                }
            });

        });
        readThread.start();
   }
    public void init() {
        deviceEngine = APIProxy.getDeviceEngine(this);
        platform = deviceEngine.getPlatform();
        deviceInfo = deviceEngine.getDeviceInfo();
        cardReader = deviceEngine.getCardReader();
        slotTypes.add(CardSlotTypeEnum.RF);
        beeper = deviceEngine.getBeeper();
        printer = deviceEngine.getPrinter();
        MobileDataController.context = this;
        MobileDataController.contentResolver = this.getContentResolver();
        WifiController.context = this;
        WifiController.wifiManager= (WifiManager)   this.getApplicationContext().getSystemService(Context.WIFI_SERVICE);

    }
}
