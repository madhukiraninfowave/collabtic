//
//  tearmsViewController.m
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "tearmsViewController.h"
#import "WebviewViewController.h"

@interface tearmsViewController ()

@end

@implementation tearmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_Cancle:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (IBAction)button_tearms:(UIButton *)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebviewViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"WebviewViewID"];
    ViewControllerObj.typeString = @"Terms and conditions";
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
    
}

- (IBAction)button_privacy:(UIButton *)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebviewViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"WebviewViewID"];
     ViewControllerObj.typeString = @"Privacy Policy";
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
}
@end
