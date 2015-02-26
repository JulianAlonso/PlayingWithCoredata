//
//  BlockBarButtonItem.h
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BarButtonItemAction)();

@interface BlockBarButtonItem : UIBarButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style andBlock:(BarButtonItemAction)block;

@end
