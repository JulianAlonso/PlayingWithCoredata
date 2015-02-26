//
//  UIImageView+ImageDownload.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "UIImageView+ImageDownload.h"
#import <objc/objc-runtime.h>
#import "ImageDownloader.h"
#import "ImageBlockOperation.h"

static NSString *const kOperationQueue = @"operationQueueKey";

@interface UIImageView (__ImageDownload)

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation UIImageView (ImageDownload)

- (void)setOperationQueue:(NSOperationQueue *)operationQueue
{
    objc_setAssociatedObject(self, (__bridge const void *)(kOperationQueue), operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)operationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, (__bridge const void *)kOperationQueue);
    
    if (!operationQueue)
    {
        operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue = operationQueue;
    }
    
    return operationQueue;
}
    
#pragma mark - SetImage method.
- (void)setImageFromUrl:(NSURL *)imageUrl completion:(CompletionBlock)completionBlock
{
    if (self.operationQueue.operationCount)
    {
        [self.operationQueue cancelAllOperations];
    }
    
    self.image = nil;
    
    ImageBlockOperation *downloadOpertaion = [[ImageDownloader sharedInstance]downloadImageWithUrl:imageUrl];

    @weakify(downloadOpertaion)
    [downloadOpertaion setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(downloadOpertaion)
            self.image = downloadOpertaion.image;
            completionBlock(self.image);
        });
    }];
    
    [self.operationQueue addOperation:downloadOpertaion];
}

@end
