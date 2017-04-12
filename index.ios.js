'use strict';

var { NativeModules } = require('react-native');
var Promisify = require('es6-promisify');
var RNIPCs = NativeModules.RNIPC;

var _startServer = promisify(RNIPCs.startServer);
var _stopServer = promisify(RNIPCs.stopServer);
var _connectClient = promisify(RNIPCs.connectClient);
var _disconnectClient = promisify(RNIPCs.disconnectClient);
var _messageToServer = promisify(RNIPCs.messageToServer);

var IPCSocket = {
    startServer() {
        return _startServer()
    },
    stopServer() {
        return _stopServer()
    },
    connectClient() {
        return _connectClient()
    },
    disconnectClient() {
        return _disconnectClient()
    },
    messageToServer() {
        return _messageToServer()
    },
};

module.exports = IPCSocket
