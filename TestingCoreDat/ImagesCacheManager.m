//
//  ImagesCacheManager.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 26/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ImagesCacheManager.h"

@interface ImagesCacheManager ()

@property (nonatomic, strong) NSMutableDictionary *cachedImages;
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@interface ImagesCacheManager (Paths)

- (NSString *)getImagePath:(NSURL *)url;
- (NSString *)getImagesDictionaryPath;

@end

@interface ImagesCacheManager (Directories)

- (void)createDirectory:(NSString *)directoryPath;

@end

@implementation ImagesCacheManager

#pragma mark - Init methods.
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSMutableDictionary *readedDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[self getImagesDictionaryPath]];
        if (!readedDictionary)
        {
            readedDictionary = [NSMutableDictionary dictionary];
        }
        
        _cachedImages = readedDictionary;
        _fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

#pragma mark - Save methods.
- (void)saveImage:(UIImage *)image withUrl:(NSURL *)url
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *imagePath = [self getImagePath:url];
    //Write img.
    if ([imageData writeToFile:imagePath atomically:YES])
    {
        [self.cachedImages setValue:imageData forKey:imagePath];
        [self saveCachedImagesDictionary];
    }
    
}

- (void)saveCachedImagesDictionary
{
    [self.cachedImages writeToFile:[self getImagesDictionaryPath] atomically:YES];
}

#pragma mark - Get methods.
- (UIImage *)getImage:(NSURL *)imageUrl
{
    NSData *imageData = [self.cachedImages valueForKey:[self getImagePath:imageUrl]];
    
    if (imageData)
    {
        return [UIImage imageWithData:imageData];
    }
    
    return nil;
}

@end


@implementation ImagesCacheManager (Paths)

- (NSString *)getImagePath:(NSURL *)url
{
    NSString *name =  [[[[[url description]
                          stringByReplacingOccurrencesOfString:@"/" withString:@""]
                          stringByReplacingOccurrencesOfString:@":" withString:@""]
                          stringByReplacingOccurrencesOfString:@"\\" withString:@""]
                          stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    return [[[self getCachePath]stringByAppendingPathComponent:name] stringByAppendingString:@".png"];
}

- (NSString *)getImagesDictionaryPath
{
    return [[self getTemporalyPath]stringByAppendingString:@"imagesDictionary.plist"];
}

- (NSString *)getTemporalyPath
{
	return NSTemporaryDirectory();
}

- (NSString *)getCachePath
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    if (directories.count)
    {
        return [[directories firstObject]stringByAppendingPathComponent:@"images"];
    }
    
    return nil;
}

@end

@implementation ImagesCacheManager (Directories)

- (void)createDirectory:(NSString *)directoryPath
{
    NSError *error;
    if (![self.fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"Error: %@", error);
    }
}

@end
