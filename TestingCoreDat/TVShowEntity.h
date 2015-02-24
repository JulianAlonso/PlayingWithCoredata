//
//  TVShowEntity.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TVShowEntity : NSManagedObject

@property (nonatomic, retain) NSString * showTitle;
@property (nonatomic, retain) NSString * showId;
@property (nonatomic, retain) NSString * showDescription;
@property (nonatomic, retain) NSSet *likedBy;
@end

@interface TVShowEntity (CoreDataGeneratedAccessors)

- (void)addLikedByObject:(NSManagedObject *)value;
- (void)removeLikedByObject:(NSManagedObject *)value;
- (void)addLikedBy:(NSSet *)values;
- (void)removeLikedBy:(NSSet *)values;

@end
