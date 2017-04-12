'use strict';

var { NativeModules } = require('react-native');
var promisify = require('es6-promisify');
var RNIPC = NativeModules.RNIPC;

var _startServer = promisify(RNIPC.startServer);
var _stopServer = promisify(RNIPC.stopServer);
var _connectClient = promisify(RNIPC.connectClient);
var _disconnectClient = promisify(RNIPC.disconnectClient);
var _messageToServer = promisify(RNIPC.messageToServer);

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
