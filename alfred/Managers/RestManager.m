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
    return manager;
}

- (instancetype) init {
    //self.baseURL = @"http://188.166.113.59:8080";
    self.baseURL = @"http://http://10.0.201.177:8080";
    httpManager = [AFHTTPRequestOperationManager manager];
    return manager;
}

- (void) GET:(NSString *)resourceURL success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [self.baseURL stringByAppendingString:resourceURL];
    
    [httpManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *result = (NSDictionary *)responseObject;
        success(result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
    
}

- (void) POST:(NSString *)resourceURL data:(NSData *) data success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSLog(@"Method not implemented yet");
}



@end
