//
//  TVShowsProvider.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "TVShowsProvider.h"
#import "AFNRequestManager.h"

@implementation TVShowsProvider

- (void)showsWithCompletion:(void(^)(NSArray *))completion
{
    [self.requestManager GET:@"shows.json" params:@{} completion:^(id data) {
        NSArray *shows = nil;
        completion(shows);
    } error:^(id data, NSError *error) {

    }];
    
}

- (id<RequestManager>)requestManager
{
    if (!_requestManager)
    {
        _requestManager = [[AFNRequestManager alloc]init];
    }
    return _requestManager;
}

@end
