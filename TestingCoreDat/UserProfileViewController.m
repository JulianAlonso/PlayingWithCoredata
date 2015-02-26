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
#import "TVShowDetailViewController.h"
#import "TVShowsProvider.h"
#import "TVshowTableViewCell.h"

@interface UserProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) NSArray *mainShows;

@property (nonatomic, strong) NSMutableDictionary *showLikes;

@property (nonatomic, strong) TVShowsProvider *showsProvider;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //delegation and datasource
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TVshowTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    NSMutableDictionary *showLikes = [NSMutableDictionary dictionaryWithContentsOfFile:[self likesPlistPath]];
    self.showLikes = showLikes ? showLikes : [NSMutableDictionary dictionary];
    
    self.showsProvider = [[TVShowsProvider alloc]init];
    
    [self loadMainShows];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ActionButtons methods.
- (IBAction)logoutButtonAction:(id)sender
{
    [self.delegate dismissUserProfileViewcontroller];
}

#pragma mark - Own methods.
- (void)loadMainShows
{
    //TODO: move to other class.
    
    NSError *error;
    
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TVShowEntity class])];
    NSArray *result = [self.managedObjectContext executeFetchRequest:select error:&error];

    if (result.count)
    {
        self.mainShows = result;
    }
    else
    {
        self.mainShows = [NSArray array];
    }
}

- (void)addLikeToShow:(TVShowEntity *)show
{
    UserEntity *currentUser = [self getCurrentUser];
    if ([show.likedBy containsObject:currentUser])
    {
        [show removeLikedByObject:currentUser];
    }
    else
    {
        [show addLikedByObject:currentUser];
    }
    NSError *error;
    [self.managedObjectContext save:&error];
}

- (NSNumber *)likesForShow:(TVShowEntity *)show
{
    return @(show.likedBy.count);
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

- (UserEntity *)getCurrentUser
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    NSError *error;
    NSArray *users = [self.managedObjectContext executeFetchRequest:select error:&error];
    
    if (users.count)
    {
        return [users firstObject];
    }
    
    return nil;
}

#pragma mark - TableView delegate and datasource methods.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVshowTableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"cell"];
    
    TVShowEntity *show = (TVShowEntity *)self.mainShows[indexPath.row];
    
    cell.showTitleLabel.text = show.showTitle;

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ecx.images-amazon.com/images/I/31vBd2jzlyL._SY300_.jpg"]]];
        //sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.showImageView.image = downloadedImage;
        });
        
    });
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainShows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 245.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVShowEntity *selectedShow = (TVShowEntity *)self.mainShows[indexPath.row];

    TVShowDetailViewController *detailViewController = (TVShowDetailViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tvShowDetailViewController"];
    
    detailViewController.show = selectedShow;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
