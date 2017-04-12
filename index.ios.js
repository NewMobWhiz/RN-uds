'use strict';

var { NativeModules } = require('react-native');
// var promisify = require('es6-promisify');
var RNIPC = NativeModules.RNIPC;

// var _messageToServer = RNIPCs.messageToServer;

var IPCSocket = {
    startServer: function() {
        return RNIPC.startServer()
    },
    stopServer: function() {
        return RNIPC.stopServer()
    },
    // connectClient() {
    //     return _connectClient()
    // },
    // disconnectClient() {
    //     return _disconnectClient()
    // },
    // messageToServer() {
    //     return _messageToServer()
    // },
};

module.exports = IPCSocket
