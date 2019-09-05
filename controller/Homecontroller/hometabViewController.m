//
//  hometabViewController.m
//  Collabtic
//
//  Created by mobile on 29/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "hometabViewController.h"
#import "ThreadsViewController.h"
#import "AppDelegate.h"
#import "menuViewController.h"


@interface hometabViewController ()

@end

@implementation hometabViewController{
    
     AppDelegate *appDelegate;
}
@dynamic tabBar;
- (void)viewDidLoad {
    [super viewDidLoad];
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
      
    // Do any additional setup after loading the view.
   
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton)];
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:swipeLeft];
//
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipeRight];
    
    [self viewWillLayoutSubviews];
}
- (void)viewWillLayoutSubviews
{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 80;
//    tabFrame.origin.y = self.view.frame.size.height - 80;
//    self.tabBar.frame = tabFrame;
    [self.tabBar setItemPositioning:UITabBarItemPositioningCentered];
    self.tabBarItem.imageInsets  = UIEdgeInsetsMake(6, 0, -8, 0);
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:153/255.0 green:46/255.0 blue:44/255.0 alpha:1.0]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Roboto-Light" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
//[UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0,0);
    self.tabBar.unselectedItemTintColor = [UIColor whiteColor];
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"%ld",item.tag);
    if(item.tag==2)
    {
     UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
       
//[self.tabBarController.navigationController pushViewController:vc animated:YES];
//
//        ControllerB *controllerB = (ControllerB *) [tabBarController.viewControllers objectAtIndex:1];
    }
    else
    {
        //your code
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    if (viewController == threadsViewController) {
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        threadsViewController * vc = [storyBoard instantiateViewControllerWithIdentifier:@"threadsViewID"];
//        [self.tabBarController.navigationController pushViewController:vc animated:YES];
//    }
   
}
//-(void)tappedRightButton{
//UITabBarController *tabBarController = [[UITabBarController alloc] init];
//
//tabBarController.selectedViewController = [tabBarController.viewControllers objectAtIndex:4];
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ThreadsViewControllerSID"]) {

        UITabBarController *tabar=segue.destinationViewController;
        ThreadsViewController *marketViewcontroller=[tabar.viewControllers objectAtIndex:1];
        [self.navigationController pushViewController:marketViewcontroller animated:NO];

    }else if ([[segue identifier] isEqualToString:@"menuViewID"]){
        
        UITabBarController *tabar=segue.destinationViewController;
        menuViewController *marketViewcontroller=[tabar.viewControllers objectAtIndex:1];
        [self.navigationController pushViewController:marketViewcontroller animated:NO];
        
    }
}


@end
