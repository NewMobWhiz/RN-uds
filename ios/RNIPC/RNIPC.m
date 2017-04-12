//
//  RNIPC.m
//  RNIPC
//
//  Created by Admin on 07/04/17.
//  Copyright © 2017 smmob. All rights reserved.
//

#import "RNIPC.h"
#import "RNIPCManager.h"

@implementation RNIPC

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(startServer:(RCTResponseSenderBlock)callback) {
    BOOL response = [[RNIPCManager sharedInstance] startServer];
    callback(@[[NSNull null], [NSNumber numberWithBool:response]]);
}

RCT_EXPORT_METHOD(stopServer:(RCTResponseSenderBlock)callback) {
    BOOL response = [[RNIPCManager sharedInstance] stopServer];
    
    callback(@[[NSNull null], [NSNumber numberWithBool:response]]);
}

RCT_EXPORT_METHOD(connectClient:(RCTResponseSenderBlock)callback) {
    BOOL response = [[RNIPCManager sharedInstance] connectClient];
    
    callback(@[[NSNull null], [NSNumber numberWithBool:response]]);
}

RCT_EXPORT_METHOD(disconnectClient:(RCTResponseSenderBlock)callback) {
    BOOL response = [[RNIPCManager sharedInstance] disconnectClient];
    
    callback(@[[NSNull null], [NSNumber numberWithBool:response]]);
}

RCT_EXPORT_METHOD(messageToServer:(NSDictionary*)message callback:(RCTResponseSenderBlock)callback) {
    [[RNIPCManager sharedInstance] messageToServer:message];
    NSString *response = [[RNIPCManager sharedInstance] getMessageFromServer:message];
    
    callback(@[[NSNull null], response]);
}

@end
