//
//  UIAlertView+Blocks.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewBlock)();

@interface UIAlertView (Blocks)

+ (instancetype)alerViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)titles buttonActions:(NSArray *)actions;

@end
