'use strict';

var { NativeModules } = require('react-native');
var RNIPC = NativeModules.RNIPC;

var IPCSocket = {
    startServer: function(callback) {
        return RNIPC.startServer(callback)
    },
    stopServer: function(callback) {
        return RNIPC.stopServer(callback)
    },
    connectClient: function(callback) {
        return RNIPC.connectClient(callback)
    },
    disconnectClient: function(callback) {
        return RNIPC.disconnectClient(callback)
    },
    messageToServer: function(message, callback) {
        return RNIPC.messageToServer(message, callback)
    },
};

module.exports = IPCSocket
