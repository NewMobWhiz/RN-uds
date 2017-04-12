//
//  RNIPCManager.h
//  RNIPC
//
//  Created by Admin on 09/04/17.
//  Copyright © 2017 smmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDUnixSocketClient.h"
#import "GDUnixSocketServer.h"

@class GDUnixSocketClient;

@interface GDClient : NSObject
@property NSString *name;
@property NSString *uinqueID;
@property BOOL connected;
@property GDUnixSocketClient *clientConnection;
@property NSMutableArray *serverMessages;
- (void)addServerMessage:(NSString *)message;
@end

@interface RNIPCManager : NSObject  <GDUnixSocketServerDelegate, GDUnixSocketClientDelegate>

@property (nonatomic, readwrite, assign) BOOL serverIsUp;
@property (nonatomic, readwrite, strong) GDUnixSocketServer *server;
@property GDClient *client;

//Server
-(BOOL)startServer;
-(BOOL)stopServer;

//Client
-(BOOL)connectClient;
-(BOOL)disconnectClient;
-(void)messageToServer:(NSDictionary *)message;
- (NSString*)getMessageFromServer:(NSString*)message;
@end
