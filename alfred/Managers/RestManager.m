//
//  RestManager.m
//  alfred
//
//  Created by Sebastian Axelsen on 05/12/15.
//  Copyright © 2015 TeamYAY. All rights reserved.
//

#import "RestManager.h"
#import <AFNetworking/AFNetworking.h>
#import <ASIHTTPRequest/ASIFormDataRequest.h>

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
        httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json",nil];

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

- (void) POST:(NSString *)resourceURL data:(NSData *)data success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [self.baseURL stringByAppendingString:resourceURL];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id result) {
        result = (NSDictionary *) result;
        success(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [operation start];

}
/*
- (void) upload:(NSString *)resourceURL data:(NSData *)data success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSString *url = [self.baseURL stringByAppendingString:resourceURL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [[NSURL alloc] initWithString:url]];
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"multipart/form-data; boundary=" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id result) {
        result = (NSDictionary *) result;
        success(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [operation start];
    
}
 */

- (void) upload:(NSString *)resourceURL data:(NSData *)data delegate:(id<ASIHTTPRequestDelegate>) delegate {
    NSString *url = [self.baseURL stringByAppendingString:resourceURL];
    NSURL *requestURL = [[NSURL alloc] initWithString:url];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    request.delegate = delegate;
    
    [request addPostValue:@"bread_query.flac" forKey:@"name"];
    [request addData:data withFileName:@"bread_query.flac" andContentType:@"audio/flac" forKey:@"file"];
    [request startAsynchronous];
}


@end
