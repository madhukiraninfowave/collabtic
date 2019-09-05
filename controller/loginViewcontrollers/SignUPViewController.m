//
//  SignUPViewController.m
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "SignUPViewController.h"
#import "tearmsViewController.h"
#import "Webservices.h"
#import "WebUrl.h"
#import "UIView+Toast.h"
#import "SignupfinalViewController.h"
#import "AppDelegate.h"


#define kOFFSET_FOR_KEYBOARD 80.0

@interface SignUPViewController (){
    AppDelegate * appDelegate;
   
    
}

@end

@implementation SignUPViewController
@synthesize profileImage,businessLogo,businessName,businessMailid;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    if (appDelegate.pickedImage == nil) {
        
    }else{
         [self.imageview_signup setImage:appDelegate.pickedImage];
    }
   
    self.imageview_signup.layer.cornerRadius = self.imageview_signup.frame.size.height / 2;
    self.imageview_signup.clipsToBounds = YES;
     
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
   
    [self.imageview_companyImage setImageURL:[NSURL URLWithString:businessLogo]];
    self.textfield_signup.userInteractionEnabled = NO;
    self.textfield_signup.text = businessMailid;
    //self.label_signup.text = businessName;
    if (appDelegate.passWord !=nil) {
         self.textfield_password.text = appDelegate.passWord;
        self.button_next.hidden = NO;
    }
   self.textfield_password.delegate = self;
    
    if (appDelegate.checkbutton == YES) {
        
        [self.button_check setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    }else{
        
        [self.button_check setImage:[UIImage imageNamed:@"Checkboxnotick"] forState:UIControlStateNormal];
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [self.view endEditing:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    [self.textfield_email resignFirstResponder];
    
    
    [self.view endEditing:YES];
    [self viewNormal];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here
    if ([self.textfield_password.text isEqualToString:@""]) {
        self.button_next.hidden = YES;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textfield_signup) {
        self.label_Emailline.backgroundColor = [UIColor whiteColor];
    }else{
        self.label_linepswd.backgroundColor = [UIColor whiteColor];
        appDelegate.passWord = [NSString stringWithFormat:@"%@",self.textfield_password.text];
        if ([self.textfield_password.text isEqualToString:@""]) {
             self.button_next.hidden = YES;
        }
    }
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textfield_signup) {
        self.label_Emailline.backgroundColor = [UIColor yellowColor];
         self.label_linepswd.backgroundColor = [UIColor whiteColor];
        [self.textfield_signup becomeFirstResponder];
    }else{
         self.button_next.hidden = YES;
         self.label_linepswd.backgroundColor = [UIColor yellowColor];
        self.label_Emailline.backgroundColor = [UIColor whiteColor];
        [self.label_Emailline becomeFirstResponder];
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }

    }
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * searchStr = [self.textfield_password.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([searchStr length] == 0) {
        self.button_next.hidden = YES;
        
    }else{
        self.button_next.hidden = NO;
       
    }
   
      return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_check:(UIButton *)sender {
    if ([self.button_check.currentImage isEqual:[UIImage imageNamed:@"Checkboxnotick"]]){
        [self.button_check setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        appDelegate.checkbutton = YES;
    
    }else{
         [self.button_check setImage:[UIImage imageNamed:@"Checkboxnotick"] forState:UIControlStateNormal];
         appDelegate.checkbutton = NO;
}
}
- (IBAction)button_tearms:(UIButton *)sender {
    [self.view endEditing:YES];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tearmsViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"tearmsViewID"];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
}

- (IBAction)button_go:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
    [self.navigationController popViewControllerAnimated:NO];
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
#pragma UItextfield Delegates



- (IBAction)button_next:(UIButton *)sender {
    
    self.textfield_password.clearsOnBeginEditing = NO;
    [self.view endEditing:YES];
    [self viewNormal];
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%@",self.textfield_signup.text], @"email",
                                          [NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key", [NSString stringWithFormat:@"2"],@"step", [NSString stringWithFormat:@"%@",self.textfield_password.text],@"password",nil];
    appDelegate.passWord = [NSString stringWithFormat:@"%@",self.textfield_password.text];
    //    NSDictionary *dictParam = @{@"parameter1":@"value1",@"parameter1":@"value2"};
    
    [Webservices requestPostUrl:signupValiedEmail parameters:parametersDictionary success:^(NSDictionary *responce) {
        //Success
        NSLog(@"responce:%@",responce);
        if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            
        }else if([self.textfield_password.text length] < 6){
            [self.view makeToast:@"Password should be minimum 6 characters"
                        duration:3.0
                        position:CSToastPositionBottom];
        }else if([self.button_check.currentImage isEqual:[UIImage imageNamed:@"Checkboxnotick"]]){
            
            [self.view makeToast:@"Please accept Terms & Policies to continue" duration:3.0 position:CSToastPositionBottom];
            
            
        }else{
            
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SignupfinalViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"SignupfinalID"];
            ViewControllerObj.profileImage = self.profileImage;
            ViewControllerObj.businessLogo = self.businessLogo;
            [self.navigationController pushViewController:ViewControllerObj animated:YES];
        }
        
        //
        
    } failure:^(NSError *error) {
        //error
    }];
    
    
}
-(void)hideKeyBoard
{
    [self viewNormal];
    [self.view endEditing:YES];
    
    
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
-(void)viewNormal{
    if (self.view.frame.origin.y ==0) {
        [self.textfield_signup resignFirstResponder];
        [self.textfield_password resignFirstResponder];
        
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.view.frame;
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
        
    }
    [UIView commitAnimations];
}
@end
