package com.statusim.ipc;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import static com.facebook.react.bridge.UiThreadUtil.runOnUiThread;

/**
 * Created by smmob on 20/04/17.
 */

public class IPCManager extends ReactContextBaseJavaModule {

    private ServiceConnection mServiceConnection;
    private boolean mIsServiceBound;
    private MyService mMyService;
    private ReactApplicationContext context;

    public IPCManager(ReactApplicationContext reactContext) {
        super(reactContext);
        context = reactContext;
        initialize();
    }

    @ReactMethod
    public void startServer() {
        context.startService(new Intent(context, MyService.class));
    }

    @ReactMethod
    public void stopServer() {
        context.stopService(new Intent(context, MyService.class));
    }

    @ReactMethod
    public void messageToServer(String message, Callback successCallback) {
        mMyService.writeData(message);
        successCallback.invoke(String.format("Receved message from client: %s", message));
    }

    @Override
    public void initialize() {
        super.initialize();
        mServiceConnection = new ServiceConnection() {
            @Override
            public void onServiceConnected(ComponentName name, IBinder service) {
                MyService.LocalBinder binder = (MyService.LocalBinder) service;
                mMyService = binder.getService();
                mIsServiceBound = true;

                mMyService.setOnDataReceivedHandler(new ISocketCommunication() {
                    @Override
                    public void onDataReceived(final String data) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                if(data != null){
                                    String logs = data.replace("\\\n", System.getProperty("line.separator"));
                                    Log.d("Recieved Data", logs);
                                }
                            }
                        });
                    }

                    @Override
                    public void onClientConnected() {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Connection Status", "Connected");
                            }
                        });
                    }

                    @Override
                    public void onClientDisconnected() {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Connection Status", "Disconnected");
                            }
                        });
                    }
                });

                mMyService.setServiceStatusHandler(new IServiceStatus() {
                    @Override
                    public void onStart() {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Service Status", "Start");
                            }
                        });
                    }

                    @Override
                    public void onStop() {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Log.d("Service Status", "Stop");
                            }
                        });
                    }
                });
            }

            @Override
            public void onServiceDisconnected(ComponentName name) {
                mIsServiceBound = false;
            }
        };

        Intent intent = new Intent(context, MyService.class);
        context.bindService(intent, mServiceConnection, Context.BIND_AUTO_CREATE);
    }

    @Override
    public String getName() {
        return "IPCManager";
    }
}
