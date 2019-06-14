//
//  SignUPViewController.m
//  Collabtic
//
//  Created by mobile on 12/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "SignUPViewController.h"
#import "tearmsViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0

@interface SignUPViewController (){
    
    
}

@end

@implementation SignUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageview_signup.layer.cornerRadius = self.imageview_signup.frame.size.height / 2;
    self.imageview_signup.clipsToBounds = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

}
- (void)viewWillAppear:(BOOL)animated
{
    [self.view endEditing:YES];
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
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textfield_signup) {
        self.label_Emailline.backgroundColor = [UIColor whiteColor];
    }else{
        self.label_linepswd.backgroundColor = [UIColor whiteColor];
    }
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textfield_signup) {
        self.label_Emailline.backgroundColor = [UIColor yellowColor];
         self.label_linepswd.backgroundColor = [UIColor whiteColor];
        [self.textfield_signup becomeFirstResponder];
    }else{
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
    
    }else{
         [self.button_check setImage:[UIImage imageNamed:@"Checkboxnotick"] forState:UIControlStateNormal];
}
}
- (IBAction)button_tearms:(UIButton *)sender {
    [self.view endEditing:YES];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tearmsViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"tearmsViewID"];
    [self.navigationController pushViewController:ViewControllerObj animated:YES];
}

- (IBAction)button_go:(UIButton *)sender {
    
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
        CGRect rect = self.view.frame;
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
        [UIView commitAnimations];
    }
}
@end
