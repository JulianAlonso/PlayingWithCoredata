//
//  ImageDownloader.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageBlockOperation;

@interface ImageDownloader : NSObject

+ (instancetype)sharedInstance;

@end

@interface ImageDownloader (ImageDownload)

- (void)getImageFromUrl:(NSURL *)url completion:(void(^)(UIImage * image))completionBlock;

- (ImageBlockOperation *)downloadImageWithUrl:(NSURL *)url;

@end
