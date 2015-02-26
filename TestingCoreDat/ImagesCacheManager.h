//
//  ImagesCacheManager.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesCacheManager : NSObject

- (void)saveImage:(UIImage *)image withUrl:(NSURL *)url;

- (UIImage *)getImage:(NSURL *)imageUrl;

@end