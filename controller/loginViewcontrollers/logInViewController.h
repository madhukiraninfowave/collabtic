//
//  logInViewController.h
//  Collabtic
//
//  Created by Yuvarani on 10/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface logInViewController : UIViewController<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfield_Login;
@property (weak, nonatomic) IBOutlet UIView *view_login;
@property (weak, nonatomic) IBOutlet UIView *view_password;
@property (weak, nonatomic) IBOutlet UITextField *textfield_password;

@property (weak, nonatomic) IBOutlet UILabel *label_loginline;
@property (weak, nonatomic) IBOutlet UILabel *label_password;
@property (weak, nonatomic) IBOutlet UIButton *button_login;
- (IBAction)button_login:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button_forgot;
- (IBAction)button_forgot:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview_login;
@property (strong, nonatomic) IBOutlet UILabel *label_login;
@property (strong, nonatomic) IBOutlet AsyncImageView *image_icon;
@property (strong, nonatomic) IBOutlet UIButton *back_login;
- (IBAction)button_loginBack:(UIButton *)sender;
#pragma image
@property (nonatomic,strong)NSString *imageCompany;
@property (nonatomic,strong)NSString *profileImage;

@property (strong, nonatomic) IBOutlet UIImageView *imageview_company;
@property (strong, nonatomic) IBOutlet NSString * businessName;
@property (strong, nonatomic) IBOutlet AsyncImageView *loginprofileimage;


@end
