//
//  UserProfileViewController.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserEntity.h"
#import "TVShowEntity.h"

@interface UserProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) NSArray *mainShows;

@property (nonatomic, strong) NSMutableDictionary *showLikes;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //delegation and datasource
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSMutableDictionary *showLikes = [NSMutableDictionary dictionaryWithContentsOfFile:[self likesPlistPath]];
    self.showLikes = showLikes ? showLikes : [NSMutableDictionary dictionary];
    
    [self loadMainShows];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonAction:(id)sender
{
    [self.delegate dismissUserProfileViewcontroller];
}

#pragma mark - Own methods.
- (void)loadMainShows
{
    TVShowEntity *show1 = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TVShowEntity class]) inManagedObjectContext:self.managedObjectContext];
    show1.showId = @"1";
    show1.showTitle = @"breakingBad";
    
    TVShowEntity *show2 = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TVShowEntity class]) inManagedObjectContext:self.managedObjectContext];
    show2.showId = @"2";
    show2.showTitle = @"Mad men";
    
    TVShowEntity *show3 = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TVShowEntity class]) inManagedObjectContext:self.managedObjectContext];
    show3.showId = @"3";
    show3.showTitle = @"SOA";
    
    self.mainShows = [NSArray arrayWithObjects:show1, show2, show3, nil];
    
}

- (void)addLikeToShow:(TVShowEntity *)show
{
    NSNumber *likes = self.showLikes[show.showId];
    if (!likes)
    {
        likes = @(0);
    }
    
    likes = @([likes integerValue] + 1);
    
    [self.showLikes setObject:likes forKey:show.showId];
}

- (NSNumber *)likesForShow:(TVShowEntity *)show
{
    NSNumber *likes = [self.showLikes objectForKey:show.showId];
    if (!likes)
    {
        return 0;
    }
    return likes;
}

- (NSString *)likesPlistPath
{
    NSString *likesPath = [NSTemporaryDirectory() stringByAppendingString:@"showsLikes.plist"];
    return likesPath;
}

- (void)saveLikes
{
    [self.showLikes writeToFile:[self likesPlistPath] atomically:YES];
}

#pragma mark - TableView delegate and datasource methods.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell"];
    
    TVShowEntity *show = (TVShowEntity *)self.mainShows[indexPath.row];
    
    cell.textLabel.text = show.showTitle;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainShows.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVShowEntity *selectedShow = (TVShowEntity *)self.mainShows[indexPath.row];
    
    [self addLikeToShow:selectedShow];
    
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"likes for show %@: %@", selectedShow.showId, [self likesForShow:selectedShow].stringValue);
    [self saveLikes];
}

@end
