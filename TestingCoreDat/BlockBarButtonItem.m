//
//  BlockBarButtonItem.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "BlockBarButtonItem.h"

@interface BlockBarButtonItem ()

@property (nonatomic, copy) BarButtonItemAction buttonBlock;

@end

@implementation BlockBarButtonItem


- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style andBlock:(BarButtonItemAction)block
{
    self = [super initWithTitle:title style:style target:self action:@selector(pressedAction)];
    
    if (self)
    {
        self.buttonBlock = block;
    }
    
    return self;
}


- (void)pressedAction
{
    self.buttonBlock();
}

@end
