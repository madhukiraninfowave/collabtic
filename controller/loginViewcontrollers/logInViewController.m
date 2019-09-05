//
//  logInViewController.m
//  Collabtic
//
//  Created by Yuvarani on 10/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "logInViewController.h"
#import "UIView+Toast.h"
#import <AFNetworking.h>
#import "WebUrl.h"
#import "Webservices.h"
#import "forgotViewController.h"
#import "hometabViewController.h"
#import "AppDelegate.h"
#define kOFFSET_FOR_KEYBOARD 80.0
@interface logInViewController (){
    
    AppDelegate * appDelegate;
    
}

@end

@implementation logInViewController
@synthesize imageCompany,businessName,profileImage;
- (void)viewDidLoad {
    [super viewDidLoad];
      appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    self.textfield_Login.delegate = self;
    self.textfield_password.delegate = self;
    self.view_login.layer.masksToBounds = YES;
    self.textfield_Login.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    self.textfield_password.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    self.loginprofileimage.layer.cornerRadius = self.loginprofileimage.frame.size.height / 2;
    self.loginprofileimage.clipsToBounds = YES;
   
    self.textfield_password.textColor = [UIColor whiteColor];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    if (imageCompany == nil) {
        
    }else{
        
         [self.image_icon setImageURL:[NSURL URLWithString:imageCompany]];
    }
    if (profileImage == nil) {
        
    }else{
        
           [self.loginprofileimage setImageURL:[NSURL URLWithString:profileImage]];
    }
 
    //
    self.textfield_Login.text = [NSString stringWithFormat:@"%@",businessName];
    self.textfield_Login.userInteractionEnabled = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_textfield_Login resignFirstResponder];
    [_textfield_password resignFirstResponder];
    [self viewNormal];
    // for Signup
//   if ([textField isEqual:self.textfield_Login]){
//        [self.textfield_Login becomeFirstResponder];
//
//    }else if ([textField isEqual:self.textfield_password]){
//        [self.textfield_Login becomeFirstResponder];
//
//    }
//    else
//    {
//        [textField resignFirstResponder];
//    }

    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
   return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textfield_Login){
        
         self.label_loginline.backgroundColor = [UIColor whiteColor];
    }else{
        
        self.label_password.backgroundColor = [UIColor whiteColor];
    }
//       if ( textField.text.length == 0){
//
//        }else{
//            NSString *url = @"http://mobile-devapi.collabtic.com//accounts/login?";
//            NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                  [NSString stringWithFormat:@"%@",self.textfield_Login.text], @"email",
//                                                  [NSString stringWithFormat:@"%@",self.textfield_password.text], @"password",
//                                                  [NSString stringWithFormat:@"%@",self.textfield_Login.text], @"username",
//                                                  nil
//                                                  ];
//
//            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//            [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//            //you can change timeout value as per your requirment
//            [manager.requestSerializer setTimeoutInterval:60.0];
//            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//            [manager POST:url parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",responseObject);
//                if ([[responseObject valueForKey:@"status"]isEqualToString:@"Failure"]) {
//                    [self.view makeToast:[responseObject valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
//
//                }else{
//                    [self.view makeToast:@"Login Successfull" duration:3.0 position:CSToastPositionBottom];
//                }
//
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"%@",error);
//            }];
//
//        }
//
//    }
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.textfield_Login) {
        self.label_loginline.backgroundColor = [UIColor yellowColor];
        self.label_password.backgroundColor = [UIColor whiteColor];
       }else if (textField == self.textfield_password){
           if  (self.view.frame.origin.y >= 0)
           {
               [self setViewMovedUp:YES];
           }
         self.label_password.backgroundColor = [UIColor yellowColor];
        self.label_loginline.backgroundColor = [UIColor whiteColor];
           
    }
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
      
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textfield_password) {
        NSString * searchStr = [self.textfield_password.text stringByReplacingCharactersInRange:range withString:string];
        if ([searchStr length] == 0) {
            self.button_login.hidden = YES;
            
        }else{
            self.button_login.hidden = NO;
            
        }
    }
 
    return YES;
}
-(void)hideKeyBoard
{
    [self.view endEditing:YES];
    [self viewNormal];
   [self.textfield_password resignFirstResponder];
   

}

-(void)viewNormal{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    if (self.view.frame.origin.y ==0) {
        [self.textfield_Login resignFirstResponder];
        [self.textfield_password resignFirstResponder];
        
    }else{
        CGRect rect = self.view.frame;
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
}
    
    [UIView commitAnimations];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_login:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.textfield_Login resignFirstResponder];
    [self.textfield_password resignFirstResponder];
         [self viewNormal];

    if ([self.textfield_Login.text isEqualToString:@""]) {
        [self.view makeToast:@"Enter a valid email address"
                    duration:3.0
                    position:CSToastPositionBottom];

    }else if ([self.textfield_password.text isEqualToString:@""]){
        [self.view makeToast:@"Password should be minimum 6 characters"
                    duration:3.0
                    position:CSToastPositionBottom];
    }else if ([self.textfield_password.text length] < 6){
        [self.view makeToast:@"Password should be minimum 6 characters"
                    duration:3.0
                    position:CSToastPositionBottom];
        
    }else{
        NSString *url =Login;
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%@",self.textfield_Login.text], @"email",
                                              [NSString stringWithFormat:@"%@",self.textfield_password.text], @"password",
                                               [NSString stringWithFormat:@"%@",self.textfield_Login.text], @"username",
                                              nil
                                              ];
[Webservices requestPostUrl:Login parameters:parametersDictionary success:^(NSDictionary *responce) {
        //Success
        if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            
        }else{
            self->appDelegate.domineID = [[responce valueForKey:@"domain_id"] intValue];
            [[NSUserDefaults standardUserDefaults] setInteger:self->appDelegate.domineID forKey:@"domainid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
             self->appDelegate.loginID = [[responce valueForKey:@"Userid"] intValue];
          [[NSUserDefaults standardUserDefaults] setInteger:self->appDelegate.loginID forKey:@"Userid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            hometabViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"homeViewID"];
           [self.navigationController pushViewController:ViewControllerObj animated:YES];
            //
//            [self.view makeToast:@"Login Successfull" duration:3.0 position:CSToastPositionBottom];
        }
        
    } failure:^(NSError *error) {
        //error
    }];
        
    }
}
- (IBAction)button_forgot:(UIButton *)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    forgotViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"forgotViewID"];
    ViewControllerObj.companyLogo = imageCompany;
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y == 0)
    {
        [self setViewMovedUp:NO];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
- (IBAction)button_loginBack:(UIButton *)sender {
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
    [self.navigationController popViewControllerAnimated:NO];
}
@end
