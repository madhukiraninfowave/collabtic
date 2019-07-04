//
//  ViewController.m
//  Collabtic
//
//  Created by Yuvarani on 06/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "ViewController.h"
#import "loginValidationViewController.h"
#import "signUpemailverifyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Action_login:(UIButton *)sender {
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loginValidationViewController  *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"loginValidationID"];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
}
- (IBAction)button_cancle:(UIButton *)sender {
   
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
     [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)button_newuser:(UIButton *)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    signUpemailverifyViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"signUpemailverifyID"];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
    
    
}
@end
