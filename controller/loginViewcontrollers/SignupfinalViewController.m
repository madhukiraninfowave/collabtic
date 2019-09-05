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
#define MAX_LENGTH 15
#define MAX_LENGTHPHONE 10

@interface SignupfinalViewController (){
    
    AppDelegate * appDelegate;
    CGRect originalviewHeight;
}

@end

@implementation SignupfinalViewController
@synthesize profileImage,businessLogo;
- (void)viewDidLoad {
    [super viewDidLoad];
     originalviewHeight = self.view.frame;
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
    
   self.button_next.frame = CGRectMake(self.button_next.frame.origin.x,self.view_phonenumber.frame.origin.y+self.button_next.frame.size.height+20, self.button_next.frame.size.width,self.button_next.frame.size.height);
    if (businessLogo == nil) {
        
    }else{
        
        [self.imageview_business setImageURL:[NSURL URLWithString:businessLogo]];
    }
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
    
    
}
-(void)viewNormal{
    if (self.view.frame.origin.y ==0) {
        [self.textfield_firstName resignFirstResponder];
        [self.textfield_lastName resignFirstResponder];
         [self.textfield_phoneNumber resignFirstResponder];
        
    }else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        CGRect rect = self.view.frame;
        rect.origin.y = 0;
         rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        self.view.frame = rect;
        
    }
    [UIView commitAnimations];
}
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
   self.view.frame = originalviewHeight;
     [UIView commitAnimations];
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
    if (textField == self.textfield_firstName) {
        NSInteger insertDelta = string.length - range.length;
        
        if (self.textfield_firstName.text.length + insertDelta > MAX_LENGTH)
        {
            return NO; // the new string would be longer than MAX_LENGTH
        }
        
    }else if (textField == self.textfield_lastName){
        NSInteger insertDelta = string.length - range.length;
        if (self.textfield_lastName.text.length + insertDelta > MAX_LENGTH)
        {
            return NO; // the new string would be longer than MAX_LENGTH
        }
        
    }else if (textField == self.textfield_phoneNumber){
        
        int length = (int)[self getLength:self.textfield_phoneNumber.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textField.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            self.textfield_phoneNumber.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            
            if(range.length > 0)
                self.textfield_phoneNumber.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    if (textField == self.textfield_firstName && self.textfield_firstName) {
        NSString * searchStr = [self.textfield_firstName.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([searchStr length] == 0) {
            self.button_next.hidden = YES;
        }else{
            self.button_next.hidden = NO;
        }
    }
   
    return YES;
}
- (NSString *)formatNumber:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = (int)[mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    return mobileNumber;
}

- (int)getLength:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = (int)[mobileNumber length];
    
    return length;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.textfield_firstName) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        self.view.frame = originalviewHeight;
        [UIView commitAnimations];
        self.label_fistName.backgroundColor = [UIColor yellowColor];
        if  (self.view.frame.origin.y >= 0 )
        {
            [self setViewMovedUp:YES];
        }
    }else if (textField == self.textfield_lastName){
        
        self.label_lastName.backgroundColor = [UIColor yellowColor];
         [self setViewMovedUp:YES];
 }else if (textField == self.textfield_phoneNumber){
        self.label_phoneName.backgroundColor = [UIColor yellowColor];
     
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationDuration:0.3]; // if you want to slide up the view
     self.view.frame = originalviewHeight;
     CGRect rect = self.view.frame;
      rect.origin.y -= kOFFSET_FOR_KEYBOARD+self.view_phonenumber.frame.size.height+2;
      rect.size.height += kOFFSET_FOR_KEYBOARD;
     
     self.view.frame = rect;
     
     [UIView commitAnimations];
     
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
    NSLog(@"viewheight%f",self.view.frame.size.height);
//    CGRect rect = self.view.frame;
//    rect.origin.y = 0;
//    rect.size.height = self.view.frame.size.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = originalviewHeight;
    [UIView commitAnimations];
    [self.view endEditing:YES];
    
    
    
}
- (IBAction)button_Go:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }
                     completion:^(BOOL finished){
                     }];
    [self.navigationController popViewControllerAnimated:NO];
    
    
    
}

-(void)imageUpload{
    //NSLog(@"self.textfield_mailid.text%@",self.textfield_mailid.text);
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%@",self.textfield_mailid.text], @"email",nil];
    NSURL *URL = [NSURL URLWithString:uploadImage];
    
    UIImage *myImageObj = appDelegate.pickedImage;
    NSData *imageData= UIImageJPEGRepresentation(myImageObj, 0.6);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URL.absoluteString parameters:parametersDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
        // etc.
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"Response: %@", responseObject);
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"image%@",json);
      
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)ProfileUpload:(NSString *)str{
    
    NSDictionary* parametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%@",self.textfield_mailid.text], @"email",
                                          
                                          [NSString stringWithFormat:@"dG9wZml4MTIz"],@"api_key",[NSString stringWithFormat:@"3"],@"step",[NSString stringWithFormat:@"%@", appDelegate.passWord],@"password", [NSString stringWithFormat:@"%@", self.textfield_firstName.text],@"firstname",[NSString stringWithFormat:@"%@", self.textfield_lastName.text],@"lastname",[NSString stringWithFormat:@"%@", str],@"imagesrc",nil];
    

    
    [Webservices requestPostUrl:signupValiedEmail parameters:parametersDictionary success:^(NSDictionary *responce) {
        [self->appDelegate.loaderView removeFromSuperview];
        NSLog(@"responce:%@",responce);
        if ([[responce valueForKey:@"status"]isEqualToString:@"Failure"]) {
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
            
        }else{
            [self.view makeToast:[responce valueForKey:@"message"] duration:3.0 position:CSToastPositionBottom];
          
            
            //Success
            
            //                UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //                SignupfinalViewController *ViewControllerObj=[storyBoard instantiateViewControllerWithIdentifier:@"SignupfinalID"];
            //                ViewControllerObj.profileImage = self.profileImage;
            //
            //                [self.navigationController pushViewController:ViewControllerObj animated:YES];
        }
        
        //
        
    } failure:^(NSError *error) {
        //error
        [self->appDelegate.loaderView removeFromSuperview];
        NSLog(@"error%@",[error description]);
    }];
    
    
}

- (IBAction)button_next:(UIButton *)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = originalviewHeight;
    [UIView commitAnimations];
    [self.view endEditing:YES];
    if ([self.textfield_firstName.text isEqualToString:@""]) {
        [self.view makeToast:@"First name should not be blank"
                    duration:3.0
                    position:CSToastPositionBottom];
    }else if ([self.textfield_lastName.text isEqualToString:@""]){
        [self.view makeToast:@"Last name should not be blank"
                    duration:3.0
                    position:CSToastPositionBottom];
    }else if ([self.textfield_phoneNumber.text isEqualToString:@""]){
        [self.view makeToast:@"Phone number should not be blank"
                    duration:3.0
                    position:CSToastPositionBottom];
    }else{
        [self.view addSubview:appDelegate.loaderView];
        if (appDelegate.pickedImage == nil) {
            [self ProfileUpload:nil];
        }else{
            [self imageUpload];
        }
        
        
        
    }
}
@end
