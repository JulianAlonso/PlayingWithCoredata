//
//  UserEntity.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TVShowEntity;

@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPassword;
@property (nonatomic, retain) NSSet *likedShows;
@end

@interface UserEntity (CoreDataGeneratedAccessors)

- (void)addLikedShowsObject:(TVShowEntity *)value;
- (void)removeLikedShowsObject:(TVShowEntity *)value;
- (void)addLikedShows:(NSSet *)values;
- (void)removeLikedShows:(NSSet *)values;

@end
