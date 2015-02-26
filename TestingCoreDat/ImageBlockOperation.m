//
//  ImageBlockOperation.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ImageBlockOperation.h"

@implementation ImageBlockOperation

- (void)cancel
{
    [self setCompletionBlock:nil];
    [super cancel];
}

@end
