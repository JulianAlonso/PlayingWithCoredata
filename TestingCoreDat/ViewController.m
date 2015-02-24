//
//  ViewController.m
//  TestingCoreDat
//
//  Created by Julian Alonso on 24/2/15.
//  Copyright (c) 2015 IronHack. All rights reserved.
//

#import "ViewController.h"
#import "UserEntity.h"
#import "UserProfileViewController.h"

static NSString *const kLastLogin = @"kLastLogin";

@interface ViewController () <UserProfileViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

@property (nonatomic, strong) UserProfileViewController *userProfileViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidAppear:(BOOL)animated
{
    if ([self checkLogin])
    {
        [self printLastLogintIfExists];
        [self presentUserProfile];
    }
}

#pragma mark - ButtonActions methods.

- (IBAction)loginButtonAction:(id)sender
{
    UserEntity *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([UserEntity class]) inManagedObjectContext:self.managedObjectContext];
    
    user.userName = self.userInput.text;
    user.userPassword = self.passwordInput.text;
    
    NSError *error;
    
    [self.managedObjectContext save:&error];
    
    if ([self checkLogin])
    {
        [self printLastLogintIfExists];
        [self presentUserProfile];
    }
}

#pragma mark - Own methods.
- (BOOL)checkLogin
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];

    NSError *error;
    NSArray *fetchResult=[self.managedObjectContext executeFetchRequest:select error:&error];
    UserEntity *user = fetchResult.count?[fetchResult firstObject]:nil;

    if (user)
    {
        [self saveLastLoginNow];
        return YES;
    }
    
    return NO;
}

- (void)presentUserProfile
{
    self.userProfileViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"userProfile"];
    
    self.userProfileViewController.managedObjectContext = self.managedObjectContext;
    self.userProfileViewController.delegate = self;
    
    [self presentViewController:self.userProfileViewController animated:YES completion:nil];
}

- (void)saveLastLoginNow
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    [[NSUserDefaults standardUserDefaults] setValue:[[NSDate date] descriptionWithLocale:currentLocale] forKey:kLastLogin];
}

- (void)printLastLogintIfExists
{
    NSString *lastLogin = [[NSUserDefaults standardUserDefaults]objectForKey:kLastLogin];
    
    NSLog(@"%@", lastLogin);
}

- (void)removeLastLogin
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kLastLogin];
}

- (BOOL)logout
{
    NSFetchRequest *select = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([UserEntity class])];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:select error:&error];
    
    UserEntity *user = result.count ? [result firstObject] : nil;
    
    [self.managedObjectContext deleteObject:user];
    
    [self.managedObjectContext save:&error];
    
    if (error) {
        return NO;
    }
    
    return YES  ;
}

- (void)cleanTempDirectory
{
    NSString *basePath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *contentOfTemp = [fileManager contentsOfDirectoryAtPath:basePath error:&error];
    
    if (!error)
    {
        for (NSString *path in contentOfTemp)
        {
            if (![fileManager removeItemAtPath:[basePath stringByAppendingPathComponent:path] error:&error])
            {
                NSLog(@"Error %@ (%@)", error, path);
            }
            
            NSLog(@"deleted file %@ at %@", path, basePath);
        }
    }
    
}

#pragma mark - UserProfileDelegate methods.
- (void)dismissUserProfileViewcontroller
{
    if ([self logout])
    {
        [self removeLastLogin];
        [self cleanTempDirectory];
        [self.userProfileViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
