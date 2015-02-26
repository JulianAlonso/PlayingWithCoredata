//
//  TVShowsProvider.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface TVShowsProvider : NSObject

@property (strong, nonatomic) id<RequestManager> requestManager;

- (void)showsWithCompletion:(void(^)(NSArray *shows))completion;

@end
