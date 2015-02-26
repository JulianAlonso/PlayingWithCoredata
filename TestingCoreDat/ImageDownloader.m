//
//  ImageDownloader.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImagesCacheManager.h"

@interface ImageDownloader ()

@property (nonatomic, strong) dispatch_queue_t image_downloader_queue;
@property (nonatomic, strong) ImagesCacheManager *imagesCacheManager;

@end

@implementation ImageDownloader

#pragma mark - Init methods.
- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _image_downloader_queue =  dispatch_queue_create("com.testingcoredat.downloader.image", DISPATCH_QUEUE_CONCURRENT);
        _imagesCacheManager = [[ImagesCacheManager alloc] init];
    }
    
    return self;
}

#pragma mark - Singleton method.
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ImageDownloader *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ImageDownloader alloc] init];
    });
    return instance;
}
@end


@implementation ImageDownloader (ImageDownload)

- (void)getImageFromUrl:(NSURL *)url completion:(void(^)(UIImage * image))completionBlock
{
    dispatch_async(self.image_downloader_queue, ^{
        
        UIImage *image = [self.imagesCacheManager getImage:url];;
        
        if (!image)
        {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
        
        [self.imagesCacheManager saveImage:image withUrl:url];
        
    });
}

@end
