package com.example.flutter_app;
import android.annotation.SuppressLint;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

public class MobileDataController {
    @SuppressLint("StaticFieldLeak")
    public static Context context;
    public static ContentResolver contentResolver;


    public static boolean isAPNInList(String apn) {
        Uri uri = Uri.parse("content://telephony/carriers");
        Cursor cursor = context.getContentResolver().query(uri, null, null, null, null);
        if (cursor != null) {
            while (cursor.moveToNext()) {
                @SuppressLint("Range") String currentAPN = cursor.getString(cursor.getColumnIndex("apn"));
                if (currentAPN.equals(apn)) {
                    cursor.close();
                    return true;
                }
            }
            cursor.close();
        }
        return false;
    }

    public static boolean createApn(String name, String apn, String ip, String port) {
        boolean isApnCreated = false;
        try {

            Uri apnUri = Uri.parse("content://telephony/carriers");
            ContentValues values = new ContentValues();
            values.put("name", name);
            values.put("apn", apn);
            values.put("mcc", "417");
            values.put("mnc", "02");
            values.put("server", ip);
            values.put("port", port);
            Cursor cursor = contentResolver.query(apnUri, null, "apn=?", new String[]{apn}, null);

            Uri newApnUri = contentResolver.insert(apnUri, values);
            isApnCreated = newApnUri != null;
            System.out.println("Created " + isApnCreated);
            if (cursor != null) {
                cursor.close();
            }
        } catch (Exception e) {
            System.out.println("error in creating apn " + e.toString());
        }
        return isApnCreated;
    }
//    public static List<Apn> getAllApns() {
//        List<Apn> apnList = new ArrayList<>();
//        ContentResolver contentResolver = context.getContentResolver();
//        Cursor cursor = null;
//        try {
//            Uri apnUri = Telephony.Carriers.CONTENT_URI;
//            cursor = contentResolver.query(apnUri, null, null, null, null);
//            if (cursor != null && cursor.moveToFirst()) {
//                do {
//                    @SuppressLint("Range") String name = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.NAME));
//                    @SuppressLint("Range") String apn = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.APN));
//                    @SuppressLint("Range") String mcc = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.MCC));
//                    @SuppressLint("Range") String mnc = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.MNC));
//                    @SuppressLint("Range") String proxy = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.PROXY));
//                    @SuppressLint("Range") String port = cursor.getString(cursor.getColumnIndex(Telephony.Carriers.PORT));
//                    System.out.println("apn " + apn);
//                    Apn apnObj = new Apn(name, apn, mcc, mnc, proxy, port);
//                    apnList.add(apnObj);
//                } while (cursor.moveToNext());
//            }
//        } finally {
//            if (cursor != null) {
//                cursor.close();
//            }
//        }
//
//        return apnList;
//    }
//    public static void deleteApn(String apn) {
//        // Define the content URI for APN settings
//        Uri uri = Uri.parse("content://telephony/carriers");
//        try {
//            int rowsDeleted = contentResolver.delete(uri, "apn = ?", new String[]{apn});
//            System.out.println("Deleted " + rowsDeleted + " APN");
//        } catch (SecurityException e) {
//            System.out.println("SecurityException: " + e.getMessage());
//        } catch (Exception e) {
//            System.out.println("Error deleting APNs: " + e.getMessage());
//        }
//    }
//    public static boolean connectToAPN(String apnName) {
//        // Get the APN ID based on the APN name
//        int apnId = getApnIdByName(apnName);
//
//        if (apnId != -1) {
//            // Set the preferred APN using the APN ID
//            return setPreferredAPN(apnId);
//        } else {
//            return false;
//        }
//    }

//    private static int getApnIdByName(String apnName) {
//        Cursor cursor = context.getContentResolver().query(
//                Uri.parse("content://telephony/carriers"),
//                new String[]{"_id"},
//                "apn = ?",
//                new String[]{apnName},
//                null
//        );
//
//        if (cursor != null && cursor.moveToFirst()) {
//            @SuppressLint("Range") int apnId = cursor.getInt(cursor.getColumnIndex("_id"));
//            cursor.close();
//            return apnId;
//        } else {
//            return -1;
//        }
//    }
//
//    private static boolean setPreferredAPN(int apnId) {
//        ContentValues values = new ContentValues();
//        values.put("_id", apnId);
//
//        int updatedRows = context.getContentResolver().update(
//                Uri.parse("content://telephony/carriers/preferapn"),
//                values,
//                null,
//                null
//        );
//
//        return updatedRows > 0;
//    }

//    public static class Apn {
//        private String name;
//        private String apn;
//        private String mcc;
//        private String mnc;
//        private String proxy;
//        private String port;
//
//        public Apn(String name, String apn, String mcc, String mnc, String proxy, String port) {
//            this.name = name;
//            this.apn = apn;
//            this.mcc = mcc;
//            this.mnc = mnc;
//            this.proxy = proxy;
//            this.port = port;
//        }

        // Add getters if necessary
//    }

    //    public static void set2GNetworkType() {
//        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        int networkType = TelephonyManager.NETWORK_TYPE_EDGE; // or TelephonyManager.NETWORK_TYPE_GPRS
////        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
////            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
////                telephonyManager.getNetworkType();
////            }
////        }
//    }
//public static void setNetworkTypeTo2G() {
//    try {
//        TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        if (telephonyManager == null) {
//            return;
//        }
//
//        // Reflection to access the hidden method setPreferredNetworkType
//        Method setPreferredNetworkTypeMethod = telephonyManager.getClass().getDeclaredMethod("setPreferredNetworkType", int.class);
//        setPreferredNetworkTypeMethod.setAccessible(true);
//
//        // Network type for 2G is 1 (GSM only)
//        int NETWORK_MODE_GSM_ONLY = 1;
//
//        // Invoke the method to set the network type to 2G
//        setPreferredNetworkTypeMethod.invoke(telephonyManager, NETWORK_MODE_GSM_ONLY);
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//}
//    private static final String TAG = "NetworkSwitcher";

//    public static void setPreferredNetworkType(int networkType) {
//        System.out.println("1");
//        try {
//            SubscriptionManager subscriptionManager = null;
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
//                subscriptionManager = (SubscriptionManager) context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE);
//                System.out.println("1");
//            }
//            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//            System.out.println("2");
//            if (subscriptionManager != null && telephonyManager != null) {
//                if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
//                    // TODO: Consider calling
//                    //    ActivityCompat#requestPermissions
//                    // here to request the missing permissions, and then overriding
//                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
//                    //                                          int[] grantResults)
//                    // to handle the case where the user grants the permission. See the documentation
//                    // for ActivityCompat#requestPermissions for more details.
//                    return;
//                }
//                List<SubscriptionInfo> subscriptionInfoList = null;
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
//                    subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();
//                    System.out.println("3");
//                }
//                if (subscriptionInfoList != null && !subscriptionInfoList.isEmpty()) {
//                    for (SubscriptionInfo subscriptionInfo : subscriptionInfoList) {
//                        int subId = 0;
//                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
//                            subId = subscriptionInfo.getSubscriptionId();
//                        }
//                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//                            telephonyManager = telephonyManager.createForSubscriptionId(subId);
//                        }
//                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
//                            telephonyManager.setPreferredNetworkTypeToGlobal();
//                        }
//                    }
//                    System.out.println("4");
//                }
//            }
//        } catch (Exception e) {
//            Log.e(TAG, "Failed to set preferred network type", e);
//        }
//    }
//
//    public static void force2G() {
//        setPreferredNetworkType(TelephonyManager.NETWORK_TYPE_GPRS);
//    }
}
