//
//  menuViewController.m
//  Collabtic
//
//  Created by mobile on 06/07/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "menuViewController.h"
#import "loginValidationViewController.h"

@interface menuViewController ()

@end

@implementation menuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logged_in"];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loginValidationViewController  *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"loginValidationID"];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
