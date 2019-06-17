//
//  signUpemailverifyViewController.m
//  Collabtic
//
//  Created by mobile on 14/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import "signUpemailverifyViewController.h"
#import "SignUPViewController.h"
#import "UIView+Toast.h"
#import <AFNetworking.h>
#import "WebUrl.h"
#import "Webservices.h"
#import "AppDelegate.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface signUpemailverifyViewController (){
    
    UIAlertController *actionSheet;
    AppDelegate * appDelegate;
}

@end

@implementation signUpemailverifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.Imageview_Profile.layer.cornerRadius = self.Imageview_Profile.frame.size.height / 2;
    self.Imageview_Profile.clipsToBounds = YES;
    self.imageview_Gallary.layer.cornerRadius = self.imageview_Gallary.frame.size.height / 2;
    self.imageview_Gallary.clipsToBounds = YES;
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

- (IBAction)buttonAction_go:(UIButton *)sender {
    [self.textfield_emailverify resignFirstResponder];
   
    if ([self.textfield_emailverify.text isEqualToString:@""]) {
        [self.view makeToast:@"Email Field should not be blank"
                    duration:3.0
                    position:CSToastPositionBottom];
        
    }else if (![self validateEmail:self.textfield_emailverify.text]){
        [self.view makeToast:@"Enter a Valied Email"
                    duration:3.0
                    position:CSToastPositionBottom];
     
      
        }else{
        NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSString stringWithFormat:@"%@",self.textfield_emailverify.text], @"email",
                                              [NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key", [NSString stringWithFormat:@"1"],@"step",nil];
        [Webservices requestPostUrl:signupValiedEmail parameters:parametersDictionary success:^(NSDictionary *responce) {
            if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
                [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
                
            }else{
                
                UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SignUPViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"signUPID"];
               ViewControllerObj.businessLogo = [[responce valueForKey:@"data"] valueForKey:@"business_logo"];
                 self->appDelegate.businessMailid =[[responce valueForKey:@"data"] valueForKey:@"email"];
                ViewControllerObj.businessMailid =[[responce valueForKey:@"data"] valueForKey:@"email"];
                ViewControllerObj.businessName =[[responce valueForKey:@"data"] valueForKey:@"business_name"];
                self->appDelegate.businessName = [[responce valueForKey:@"data"] valueForKey:@"business_name"];
                ViewControllerObj.profileImage = self.Imageview_Profile.image;
                [self.navigationController pushViewController:ViewControllerObj animated:YES];
            }
                
            } failure:^(NSError *error) {
                //error
            }];
        
    }
    
}
-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
- (IBAction)button_profileImage:(UIButton *)sender {
    [self.view endEditing:YES];
   actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
  
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallary" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self imagePicker];
        // Distructive button tapped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        [self Camera];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
-(void)imagePicker{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    [self presentViewController:picker animated:YES completion:NULL];
}];
}
-(void)Camera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:picker animated:YES completion:NULL];
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.Imageview_Profile.image = chosenImage;
    self->appDelegate.pickedImage = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)hideKeyBoard
{
   
    [self.view endEditing:YES];
    
    
    
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}
@end
