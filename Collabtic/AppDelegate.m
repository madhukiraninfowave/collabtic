//
//  AppDelegate.m
//  Collabtic
//
//  Created by Yuvarani on 06/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import  <AFURLSessionManager.h>
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "hometabViewController.h"

@class WebService;

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AppDelegate () {
   
}

@property (nonatomic, strong)Reachability * internetReach;
@end

@implementation AppDelegate
@synthesize loginID,internetWorking,loaderView,businessName,businessMailid,businessLogo,pickedImage,passWord,pickedImageUrl,checkbutton,loginStatus,domineID;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *navController;
  
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
   [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkNetworkStatus:)
                                                 name:kReachabilityChangedNotification object:nil];
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    [self checkNetworkStatus:nil];
    
    self.window.hidden=NO;
   
    self.loaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    self.loaderView.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.5];
    
    progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake((self.window.frame.size.width/2)-25,(self.window.frame.size.height/2)-65,50,50)];
    progressView.roundedCorners = YES;
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.progressTintColor= [UIColor colorWithRed:216/255.0f green:61/255.0f blue:61/255.0f alpha:1.0f];
    progressView.center=self.loaderView.center;
    [self.loaderView addSubview:progressView];
    [self startAnimation];
    self.activityIndicator = [[UIActivityIndicatorView alloc]init];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    //    self.activityIndicator.color = [UIColor colorWithRed:55/255.0f green:139/255.0f blue:43/255.0f alpha:1];
    self.activityIndicator.color = [UIColor colorWithRed:214/255.0f green:108/255.0f blue:154/255.0f alpha:1];
    self.activityIndicator.frame=CGRectMake(0,0,100,50);
    //    self.activityIndicator.backgroundColor=[UIColor lightGrayColor];
    self.activityIndicator.center=self.window.center;
    self.activityIndicator.layer.cornerRadius=2.0;
    self.activityIndicator.layer.masksToBounds=YES;

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Userid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"domainid"];
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.loaderView removeFromSuperview];
        WelcomeViewController  *HomeViewObj=[storyBoard instantiateViewControllerWithIdentifier:@"WelcomeViewControllerID"];
        navController = [[UINavigationController alloc]initWithRootViewController:HomeViewObj];
        [navController setNavigationBarHidden:YES animated:YES];
        [self.window setRootViewController:navController];
        [self.window makeKeyAndVisible];
        return YES;
        
    }else{
        loginID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Userid"] intValue];
        domineID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"domainid"] intValue];
      UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.loaderView removeFromSuperview];
        hometabViewController  *HomeViewObj=[storyBoard instantiateViewControllerWithIdentifier:@"homeViewID"];
        navController = [[UINavigationController alloc]initWithRootViewController:HomeViewObj];
        [navController setNavigationBarHidden:YES animated:YES];
        [self.window setRootViewController:navController];
        [self.window makeKeyAndVisible];
        return YES;
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)startAnimation
{
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.03                                                  target:self                                                selector:@selector(progressChange)                                                userInfo:nil                                                 repeats:YES];
    
    
    
}
#pragma mark INTERNET REACHABILITY

- (void)checkNetworkStatus:(NSNotification *)notice
{
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        internetWorking = 0;
        //NSLog(@"checkNetworkStatus- The internet is down.");
    }
    else
    {
        internetWorking = 1;
        //        //NSLog(@"checkNetworkStatus- The internet is working!");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INTERNET_AVAILABLE" object:nil];
    }
}
- (void)progressChange
{
    NSArray *progressViews = @[
                               progressView
                               ];
    
    for (DACircularProgressView *progressView in progressViews)
    {
        
        CGFloat progress = ![timer isValid] ? 5 / 10.0f : progressView.progress + 0.01f;
        [progressView setProgress:progress animated:YES];
        
        if (progressView.progress >= 1.0f && [timer isValid])
        {
            [progressView setProgress:0.f animated:YES];
            
        }
        
    }
    // Labeled progress views
    
    
}

#pragma deeplinking
- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSString *myUrl = [userActivity.webpageURL absoluteString];
        NSLog(@"myUrl==%@",myUrl);
    }
    // Debug log something here
    return YES;
}

@end
