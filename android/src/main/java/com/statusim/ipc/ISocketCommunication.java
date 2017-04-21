package com.statusim.ipc;

/**
 * Created by smmob on 20/04/17.
 */

public interface ISocketCommunication {
    void onDataReceived(String data);
    void onClientConnected();
    void onClientDisconnected();
}
