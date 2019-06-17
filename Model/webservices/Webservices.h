//
//  Webservices.h
//  Collabtic
//
//  Created by mobile on 15/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Webservices : NSObject
+  (void)requestPostUrl:(NSString *)strURL parameters:(NSDictionary *)dictParams success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure;

+  (void)requestGetUrl:(NSString *)strURL success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
