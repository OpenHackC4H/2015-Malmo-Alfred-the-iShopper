//
//  RestManager.h
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASIHTTPRequestDelegate;

@interface RestManager : NSObject 
+ (RestManager *) sharedManager;

- (void) GET:(NSString *)resourceURL success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;


- (void) POST:(NSString *)resourceURL data:(NSData *) data success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

- (void) upload:(NSString *)resourceURL data:(NSData *)data delegate:(id<ASIHTTPRequestDelegate>) delegate;

@end
