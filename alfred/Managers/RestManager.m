//
//  RestManager.m
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import "RestManager.h"
#import <AFNetworking/AFNetworking.h>

#

@interface RestManager ()

@property (strong, nonatomic) NSString *baseURL;

@end

@implementation RestManager

static RestManager *manager = nil;
AFHTTPRequestOperationManager *httpManager;


+(RestManager *) sharedManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[RestManager alloc] init];
    });
    NSLog(@"Getting rest manager");
    NSLog(@"HttpManager: %@", [httpManager description]);
    return manager;
}

- (id) init {
    self = [super init];
    
    if(self) {
        self.baseURL = @"http://alfred.eu-gb.mybluemix.net";
        httpManager = [AFHTTPRequestOperationManager manager];
        httpManager.requestSerializer.timeoutInterval = 5;
        httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json",nil];

    }
    
    return self;
}

- (void) GET:(NSString *)resourceURL success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [self.baseURL stringByAppendingString:resourceURL];
    
    [httpManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        success(result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}

- (void) POST:(NSString *)resourceURL data:(NSData *) data success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSLog(@"Method not implemented yet");
}



@end
