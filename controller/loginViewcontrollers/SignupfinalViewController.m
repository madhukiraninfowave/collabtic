//
//  SignupfinalViewController.m
//  Collabtic
//
//  Created by mobile on 15/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "SignupfinalViewController.h"
#import "Webservices.h"
#import "WebUrl.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"
#define kOFFSET_FOR_KEYBOARD 80.0
@interface SignupfinalViewController (){
    
    AppDelegate * appDelegate;
}

@end

@implementation SignupfinalViewController
@synthesize profileImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
    self.imagevie_profile.layer.cornerRadius = self.imagevie_profile.frame.size.height / 2;
    self.imagevie_profile.clipsToBounds = YES;
    if (appDelegate.pickedImage == nil) {
        
    }else{
        
            self.imagevie_profile.image = appDelegate.pickedImage;
    }

    self.textfield_businessName.text = appDelegate.businessName;
    self.textfield_businessName.userInteractionEnabled = NO;
    self.textfield_mailid.text = appDelegate.businessMailid;
    self.textfield_mailid.userInteractionEnabled = NO;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewNormal{
    if (self.view.frame.origin.y ==0) {
        [self.textfield_firstName resignFirstResponder];
        [self.textfield_lastName resignFirstResponder];
         [self.textfield_phoneNumber resignFirstResponder];
        
    }else{
        CGRect rect = self.view.frame;
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
        
    }
    [UIView commitAnimations];
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self viewNormal];
    [self.view endEditing:YES];
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
   return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textfield_firstName) {
        self.label_fistName.backgroundColor = [UIColor whiteColor];
    }else if (textField == self.textfield_lastName){
         self.label_lastName.backgroundColor = [UIColor whiteColor];
    }else if (textField == self.textfield_phoneNumber){
        
         self.label_phoneName.backgroundColor = [UIColor whiteColor];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textfield_firstName) {
        self.label_fistName.backgroundColor = [UIColor yellowColor];
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }else if (textField == self.textfield_lastName){
        self.label_lastName.backgroundColor = [UIColor yellowColor];
         [UIView beginAnimations:nil context:NULL];
          [UIView setAnimationDuration:0.3];
            CGRect rect = self.view.frame;
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD+self.textfield_firstName.frame.size.height+5;
         self.view.frame = rect;
        [UIView commitAnimations];
       
        
    }else if (textField == self.textfield_phoneNumber){
        self.label_phoneName.backgroundColor = [UIColor yellowColor];
         if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
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

-(void)hideKeyBoard
{
    [self viewNormal];
    [self.view endEditing:YES];
    
    
}
@end
