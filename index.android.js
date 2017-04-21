'use strict';

var { NativeModules } = require('react-native');
var RNIPC = NativeModules.IPCPackage;

var IPCSocket = {
    startServer: function(callback) {
        return RNIPC.startServer(callback)
    },
    stopServer: function(callback) {
        return RNIPC.stopServer(callback)
    },
    messageToServer: function(message, callback) {
        return RNIPC.messageToServer(message, callback)
    },
};

module.exports = IPCSocket
