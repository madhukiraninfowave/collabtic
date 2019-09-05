//
//  SignupfinalViewController.h
//  Collabtic
//
//  Created by mobile on 15/06/19.
//  Copyright © 2019 InfoWave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <AFNetworking.h>
 

NS_ASSUME_NONNULL_BEGIN

@interface SignupfinalViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet AsyncImageView *imagevie_profile;
@property (strong, nonatomic) IBOutlet UILabel *label_newuser;

@property (strong, nonatomic) IBOutlet UITextField *textfield_businessName;
@property (strong, nonatomic) IBOutlet UITextField *textfield_mailid;
@property (strong, nonatomic) IBOutlet UITextField *textfield_firstName;
@property (strong, nonatomic) IBOutlet UITextField *textfield_lastName;

@property (strong, nonatomic) IBOutlet UITextField *textfield_phoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *button_back;
- (IBAction)button_back:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_fistName;
@property (strong, nonatomic) IBOutlet UILabel *label_lastName;
@property (strong, nonatomic) IBOutlet UILabel *label_phoneName;
@property(nonatomic,strong)UIImage*profileImage;
@property (strong, nonatomic) IBOutlet UIView *view_fistname;
@property (strong, nonatomic) IBOutlet UIView *view_lastName;
@property (strong, nonatomic) IBOutlet UIView *view_phonenumber;
@property (strong, nonatomic) IBOutlet UIButton *button_go;
- (IBAction)button_Go:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *button_next;
@property (nonatomic,strong)NSString*businessLogo;
- (IBAction)button_next:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageview_business;

@end

NS_ASSUME_NONNULL_END
