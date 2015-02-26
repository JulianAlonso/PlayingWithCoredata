//
//  RequestManager.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "AFNRequestManager.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const baseDomain = @"http://ironhack4thweek.s3.amazonaws.com"; //@"http://api.trakt.tv";

@implementation AFNRequestManager

- (void)GET:(NSString *)endpoint params:(NSDictionary *)params completion:(SuccessBlock)completionBlock error:(ErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[baseDomain stringByAppendingPathComponent:endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(nil, error);
    }];
}

- (void)POST:(NSString *)endpoint params:(NSDictionary *)params completion:(SuccessBlock)completionBlock error:(ErrorBlock)errorBlock
{
    
}

@end
