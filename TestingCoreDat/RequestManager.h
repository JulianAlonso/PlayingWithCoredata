//
//  RequestManager.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id data);
typedef void (^ErrorBlock)(id data, NSError *error);

@protocol RequestManager <NSObject>

- (void)GET:(NSString *)endpoint params:(NSDictionary *)params completion:(SuccessBlock)completionBlock error:(ErrorBlock)errorBlock;

- (void)POST:(NSString *)endpoint params:(NSDictionary *)params completion:(SuccessBlock)completionBlock error:(ErrorBlock)errorBlock;

@end
