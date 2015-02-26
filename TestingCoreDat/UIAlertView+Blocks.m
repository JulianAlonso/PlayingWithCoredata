//
//  UIAlertView+Blocks.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *const alertViewBlockKey = @"alertViewBlock";

@interface UIAlertView (__Blocks) <UIAlertViewDelegate>

@property (nonatomic, copy) NSArray *buttonBlocks;

@end

@implementation UIAlertView (Blocks)

+ (instancetype)alerViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)titles buttonActions:(NSArray *)actions
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    if (alert)
    {
        alert.delegate = alert;
        
        for (NSString *title in titles)
        {
            [alert addButtonWithTitle:title];
        }
        
        alert.buttonBlocks = actions;
    }
    
    return alert;
}

#pragma mark - Setter and Getters methods.
- (void)setButtonBlocks:(NSArray *)buttonBlocks
{
    objc_setAssociatedObject(self, (__bridge const void *)(alertViewBlockKey), buttonBlocks, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray *)buttonBlocks
{
    return objc_getAssociatedObject(self, (__bridge const void *)(alertViewBlockKey));
}

#pragma mark - UIAlertView methods.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertViewBlock block = alertView.buttonBlocks[buttonIndex];
    block();
}

@end
