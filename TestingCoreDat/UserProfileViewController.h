//
//  UserProfileViewController.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserProfileViewControllerProtocol <NSObject>

- (void)dismissUserProfileViewcontroller;

@end

@interface UserProfileViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) id<UserProfileViewControllerProtocol> delegate;

@end
