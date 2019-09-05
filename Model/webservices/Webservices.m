//
//  Webservices.m
//  Collabtic
//
//  Created by mobile on 15/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "Webservices.h"
#import <AFNetworking.h>

@implementation Webservices
+  (void)requestPostUrl:(NSString *)strURL parameters:(NSDictionary *)dictParams success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //you can change timeout value as per your requirment
    [manager.requestSerializer setTimeoutInterval:60.0];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy.validatesDomainName = NO;
    [manager POST:strURL parameters:dictParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(success) {
                success(responseObject);
            }
        }
        else {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                success(response);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
        
    }];
}


+  (void)requestGetUrl:(NSString *)strURL success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
