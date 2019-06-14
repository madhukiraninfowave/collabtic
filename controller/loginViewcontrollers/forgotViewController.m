//
//  forgotViewController.m
//  Collabtic
//
//  Created by Yuvarani on 11/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "forgotViewController.h"
#import "UIView+Toast.h"
#import <AFNetworking.h>
#import "AppDelegate.h"

@interface forgotViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation forgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   [self.button_reset.titleLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:16.0]];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    self.textfield_email.font = [UIFont fontWithName:@"Roboto-Bold" size:16.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_reset:(UIButton *)sender {
    
    [self.textfield_email resignFirstResponder];
    if ([self.textfield_email.text isEqualToString:@""]) {
        [self.view makeToast:@"Enter a vaid email adress"
                    duration:3.0
                    position:CSToastPositionBottom];
    }else{
        [self.view addSubview:appDelegate.loaderView];
        NSString *url = @"http://mobile-devapi.collabtic.com//accounts/resetpassword/accounts/resetpassword?";
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%@",self.textfield_email.text], @"email",
                                              [NSString stringWithFormat:@"%@",@"mobile"],@"access_type",
                                            
                                              nil
                                              ];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        //you can change timeout value as per your requirment
        [manager.requestSerializer setTimeoutInterval:60.0];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [manager POST:url parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           // NSLog(@"%@",responseObject);
            if ([[responseObject valueForKey:@"status"]intValue] == 0) {
                [self->appDelegate.loaderView removeFromSuperview];
                [self.view makeToast:[responseObject valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
                
            }else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Collabtic"
                                                                               message:@"Link has been send Successfully."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                    [self okButtonPressed];
                                                                      }];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                
               

            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [self->appDelegate.loaderView removeFromSuperview];
        }];
    }
    
}

#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.textfield_email resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.label_colered.backgroundColor = [UIColor whiteColor];
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textfield_email) {
        self.label_colered.backgroundColor = [UIColor yellowColor];
    }
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}
-(void)hideKeyBoard
{
    [self.textfield_email resignFirstResponder];
  
}

- (IBAction)button_back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)okButtonPressed{
    
    [appDelegate.loaderView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
   
}

@end
