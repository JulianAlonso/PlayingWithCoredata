//
//  CoreDataStack.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)initWithModelName:(NSString *)modelName;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
