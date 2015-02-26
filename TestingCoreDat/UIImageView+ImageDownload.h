//
//  UIImageView+ImageDownload.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(UIImage * image);

@interface UIImageView (ImageDownload)

- (void)setImageFromUrl:(NSURL *)imageUrl completion:(CompletionBlock)completionBlock;

@end
