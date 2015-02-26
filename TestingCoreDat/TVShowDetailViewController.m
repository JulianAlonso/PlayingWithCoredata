//
//  TVShowDetailViewController.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 25/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "TVShowDetailViewController.h"
#import "BlockBarButtonItem.h"
#import "UIAlertView+Blocks.h"

@interface TVShowDetailViewController ()

@property (nonatomic, strong) BlockBarButtonItem *blockBarButtonItem;

@end

@implementation TVShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    self.blockBarButtonItem = [[BlockBarButtonItem alloc] initWithTitle:@"Block" style:UIBarButtonItemStylePlain andBlock:^{
        @strongify(self)
        [self showAlertView];
    }];

    self.navigationItem.rightBarButtonItem = self.blockBarButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)showAlertView
{
    UIAlertView *alert = [UIAlertView alerViewWithTitle:@"Alert"
                                                message:@"Hello World"
                                           buttonTitles:@[@"Ok", @"Cancel"]
                                          buttonActions:@[^{
        NSLog(@"ok pressed");
    }, ^{
        NSLog(@"cancel pressed");
    }
  ]];
    
    [alert show];
}

- (void)dealloc
{
    NSLog(@"muero");
}

@end
